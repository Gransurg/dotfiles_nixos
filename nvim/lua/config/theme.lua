-- Shared colorscheme behaviour, applied to EVERY scheme (not just nightfox):
--   * strip the "canvas" backgrounds so the terminal shows through (transparency)
--   * kill italics everywhere except comments
--   * remember the last-picked scheme and restore it on the next launch
--
-- Registered from init.lua *before* lazy loads any plugin, so the very first
-- colorscheme of the session already goes through here.
local M = {}

-- Groups whose background we blank out. These are the editor "canvas" + chrome;
-- syntax/selection groups keep their backgrounds on purpose.
local transparent_groups = {
	-- editor core
	"Normal",
	"NormalNC",
	"EndOfBuffer",
	"MsgArea",
	"MsgSeparator",
	"StatusLine",
	"StatusLineNC",
	"WinBar",
	"WinBarNC",
	"WinSeparator",
	-- floats / popups and their chrome
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"FloatFooter",
	"FloatShadow",
	"FloatShadowThrough",
	"Pmenu",
	"PmenuKind",
	"PmenuExtra",
	"PmenuSbar",
	-- number column / gutter (LineNrAbove/Below link to LineNr)
	"SignColumn",
	"LineNr",
	"CursorLineNr",
	"FoldColumn",
	-- diagnostic + git signs (themes often tint these even with transparency on;
	-- this is what bled into the noice borders)
	"DiagnosticSignError",
	"DiagnosticSignWarn",
	"DiagnosticSignInfo",
	"DiagnosticSignHint",
	"DiagnosticSignOk",
	"GitSignsAdd",
	"GitSignsChange",
	"GitSignsDelete",
	"TreesitterContextLineNumber",
	"NotifyBackground",
}

local function strip_backgrounds()
	for _, group in ipairs(transparent_groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		if next(hl) ~= nil then
			hl.bg = nil
			hl.ctermbg = nil
			vim.api.nvim_set_hl(0, group, hl)
		end
	end
end

-- Comments stay italic; strip italic from everything else. Runs over every
-- highlight group the active scheme defines, so it works for any colorscheme
-- without per-theme configuration. Groups whose name mentions comment / italic /
-- emphasis are left alone (that's semantic italic we want to keep).
local function fix_italics()
	for name, def in pairs(vim.api.nvim_get_hl(0, {})) do
		if
			def.italic
			and not name:find("omment")
			and not name:find("[Ii]talic")
			and not name:find("[Ee]mphasis")
		then
			def.italic = nil
			-- pcall so one group whose def can't round-trip through nvim_set_hl
			-- can't abort the sweep and leave later groups (e.g. @variable) italic.
			pcall(vim.api.nvim_set_hl, 0, name, def)
		end
	end

	-- ...and make sure comments *are* italic, even on schemes that don't do it
	-- by default (github, poimandres), so comments are the one italic exception.
	for _, name in ipairs({ "Comment", "@comment", "@comment.documentation" }) do
		local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
		if next(hl) ~= nil then
			hl.italic = true
			pcall(vim.api.nvim_set_hl, 0, name, hl)
		end
	end
end

local function strip_bufferline_backgrounds()
	for _, group in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		if hl.bg then
			vim.api.nvim_set_hl(0, group, {
				fg = hl.fg,
				sp = hl.sp,
				bold = hl.bold,
				italic = hl.italic,
				underline = hl.underline,
				underdouble = hl.underdouble,
			})
		end
	end
end

-- Where the last-picked scheme is remembered between launches.
local persist_path = vim.fn.stdpath("state") .. "/last_colorscheme"

function M.save(name)
	if type(name) == "string" and name ~= "" then
		pcall(vim.fn.writefile, { name }, persist_path)
	end
end

function M.load()
	local ok, lines = pcall(vim.fn.readfile, persist_path)
	if ok and lines and lines[1] and lines[1] ~= "" then
		return lines[1]
	end
	return nil
end

-- One place that normalises the active scheme. Each step is pcall-guarded and
-- independent, so a single un-settable highlight group can't abort the rest
-- (that was leaving code italic when a scheme loaded in a fully-populated
-- session with lots of plugin/LSP highlight groups).
local function apply_fixes()
	pcall(strip_backgrounds)
	pcall(fix_italics)
	vim.schedule(strip_bufferline_backgrounds)
end

-- Re-assert the fixes once the dust settles, debounced. Telescope's colorscheme
-- picker (<leader>uc) applies schemes asynchronously -- rapid previews plus an
-- Esc-restore -- and the immediate ColorScheme pass can race that, leaving the
-- scheme that's actually on screen un-stripped and the wrong name persisted.
-- Renormalise + persist ~50ms after the last change, from whatever won.
local reassert_gen = 0
local function schedule_reassert()
	reassert_gen = reassert_gen + 1
	local mine = reassert_gen
	vim.defer_fn(function()
		if mine ~= reassert_gen then
			return -- superseded by a newer scheme change; let that one win
		end
		apply_fixes()
		M.save(vim.g.colors_name)
	end, 50)
end

function M.setup()
	-- Capture the persisted pick *now*, before nightfox's startup colorscheme
	-- fires the ColorScheme autocmd and overwrites the file.
	local pending = M.load()

	local group = vim.api.nvim_create_augroup("UserTheme", { clear = true })

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			apply_fixes()
			-- Whatever scheme just took effect (incl. a Telescope preview you land
			-- on with <CR>) becomes the pick that survives a restart.
			M.save(vim.g.colors_name)
			-- ...and re-assert once the picker's async churn settles, so a scheme
			-- applied in a racy context is still normalised + persisted correctly.
			schedule_reassert()
		end,
	})

	-- bufferline can load after the colorscheme; re-strip when it does / on buffer changes
	vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
		group = group,
		callback = function()
			vim.schedule(strip_bufferline_backgrounds)
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "LazyLoad",
		callback = function(ev)
			if ev.data == "bufferline.nvim" then
				vim.schedule(strip_bufferline_backgrounds)
			end
		end,
	})

	-- Restore the last-picked scheme once every scheme plugin has loaded.
	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		once = true,
		callback = function()
			if pending and pending ~= vim.g.colors_name then
				if not pcall(vim.cmd.colorscheme, pending) then
					pcall(vim.cmd.colorscheme, "nightfox")
				end
			end
		end,
	})
end

return M
