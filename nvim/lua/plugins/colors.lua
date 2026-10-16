return {
	-- Transparency + "no italics except comments" + last-scheme persistence for
	-- every colorscheme below live in lua/config/theme.lua, wired up in init.lua.
	-- Switch live with <leader>uc (Telescope preview, <CR> applies + persists).
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
					dim_inactive = false,
					styles = {
						comments = "italic",
					},
				},
				groups = {
					all = {
						-- jagged diagnostic underlines: red errors, blue everything-else
						DiagnosticUnderlineError = { style = "undercurl", sp = "palette.red.base" },
						DiagnosticUnderlineWarn = { style = "undercurl", sp = "palette.blue.base" },
						DiagnosticUnderlineInfo = { style = "undercurl", sp = "palette.blue.base" },
						DiagnosticUnderlineHint = { style = "undercurl", sp = "palette.blue.base" },
						DiagnosticUnnecessary = { style = "undercurl", sp = "palette.blue.base" },
					},
				},
			})

			-- Startup default; config.theme restores your last pick over this.
			vim.cmd.colorscheme("nightfox")

			local palette = require("nightfox.palette").load("nightfox")

			-- Snacks dashboard header + directory follow the colorscheme
			vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = palette.red.base })
			vim.api.nvim_set_hl(0, "Directory", { fg = palette.blue.base, bg = "NONE" })
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		config = function()
			require("rose-pine").setup({ styles = { transparency = true } })
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		config = function()
			-- the colorblind variant is `github_dark_colorblind` in the picker
			require("github-theme").setup({ options = { transparent = true } })
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
	},
	{
		"olivercederborg/poimandres.nvim",
		lazy = false,
		config = function()
			require("poimandres").setup({
				disable_background = true,
				disable_float_background = true,
			})
		end,
	},
	{
		"sainnhe/everforest",
		lazy = false,
		config = function()
			-- vimscript scheme: configured via globals. Italics stay off here;
			-- config.theme re-asserts italic comments + strips the rest.
			vim.g.everforest_background = "medium"
			vim.g.everforest_transparent_background = 1
			vim.g.everforest_enable_italic = 0
		end,
	},
	{
		"vimcolorschemes/olive-crt.nvim",
		lazy = false,
		config = function()
			-- module name is olive_crt (underscore), not the repo's olive-crt
			require("olive_crt").setup({ transparent = true })
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search todos" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local theme = require("lualine.themes.seoul256")
			-- local theme = require("lualine.themes.palenight")
			for _, mode in pairs(theme) do
				if mode.a and mode.a.bg then
					mode.a.fg = mode.a.bg
				end
				for _, section in pairs(mode) do
					section.bg = "NONE"
				end
			end

			-- show macro recording status in the statusline (cmdheight=0 hides neovim's default "recording @q" message).
			local function macro_recording()
				local reg = vim.fn.reg_recording()
				if reg == "" then
					return ""
				end
				return "recording @" .. reg
			end

			local macro_group = vim.api.nvim_create_augroup("LualineMacroRecording", { clear = true })
			vim.api.nvim_create_autocmd("RecordingEnter", {
				group = macro_group,
				callback = function()
					require("lualine").refresh()
				end,
			})
			vim.api.nvim_create_autocmd("RecordingLeave", {
				group = macro_group,
				callback = function()
					-- reg_recording() is still set during RecordingLeave, so repaint next tick
					vim.defer_fn(function()
						require("lualine").refresh()
					end, 50)
				end,
			})

			return {
				options = {
					theme = theme,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_c = {
						"filename",
						{ macro_recording, color = { fg = "#ff5555", gui = "bold" } },
					},
					lualine_z = { "location" },
				},
			}
		end,
	},
}
