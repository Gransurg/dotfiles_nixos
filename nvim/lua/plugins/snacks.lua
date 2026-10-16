return {
	{
		"folke/snacks.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		priority = 1000,
		lazy = false,
		keys = {
			-- Opens lazygit in a float (uses your lazygit config, incl. delta paging).
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			-- File explorer (replaces mini.files)
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
		},
		opts = {
			-- explorer is a picker source; picker must be enabled.
			-- replace_netrw = false so oil.nvim owns directory/netrw opening instead.
			picker = {
				enabled = true,
				sources = {
					-- show dotfiles in the explorer by default (toggle with `H`)
					explorer = { hidden = true },
				},
			},
			explorer = { replace_netrw = false },
			indent = {
				enabled = true,
				animate = {
					style = "down",
				},
			},
			dashboard = {
				enabled = true,
				preset = {
					header = [[
                                                                     
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]],
					keys = {
						{ icon = "󰈞", key = "f", desc = "Find File", action = ":Telescope find_files" },
						{ icon = "󰝒", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = "󰊄", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
						{ icon = "󱋡", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
						{
							icon = "󰒓",
							key = "c",
							desc = "Config",
							action = function()
								require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
							end,
						},
						{ icon = "󰒲", key = "L", desc = "Lazy", action = ":Lazy" },
						{ icon = "󰅚", key = "q", desc = "Quit", action = ":qa" },
					},
				},
			},
		},
	},

	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "*",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		-- close the current buffer without nuking the window/layout
	-- 		{
	-- 			"<leader>bd",
	-- 			function()
	-- 				Snacks.bufdelete()
	-- 			end,
	-- 			desc = "Delete buffer",
	-- 		},
	-- 		-- H / L cycle between buffers (overrides the default High/Low motions)
	-- 		{ "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
	-- 		{ "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
	-- 	},
	-- 	opts = {
	-- 		options = {
	-- 			mode = "buffers",
	-- 			numbers = "none",
	-- 			diagnostics = false,
	--
	-- 			show_buffer_icons = true, -- coloured devicon per filetype
	-- 			color_icons = true,
	-- 			show_buffer_close_icons = false, -- no per-tab x
	-- 			show_close_icon = false, -- no global x on the right
	-- 			show_duplicate_prefix = true, -- disambiguate same-named files
	--
	-- 			indicator = { style = "underline" },
	-- 			show_tab_indicators = false,
	-- 			separator_style = { "", "" },
	--
	-- 			offsets = {
	-- 				{ filetype = "snacks_layout_box", text = "", separator = false },
	-- 			},
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("bufferline").setup(opts)
	--
	-- 		local function thicken_underline()
	-- 			for _, name in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
	-- 				local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	-- 				if hl.underline or hl.underdouble then
	-- 					vim.api.nvim_set_hl(0, name, {
	-- 						fg = hl.fg,
	-- 						bg = hl.bg,
	-- 						sp = hl.sp,
	-- 						bold = hl.bold,
	-- 						underline = true,
	-- 					})
	-- 				end
	-- 			end
	-- 		end
	--
	-- 		thicken_underline()
	-- 		vim.api.nvim_create_autocmd({ "ColorScheme", "BufWinEnter", "BufEnter" }, {
	-- 			callback = function()
	-- 				vim.schedule(thicken_underline)
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
