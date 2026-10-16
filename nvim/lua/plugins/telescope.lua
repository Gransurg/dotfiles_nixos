return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope find files",
		},
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Telescope find files",
		},
		{
			"<leader>sg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Telescope buffers",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Telescope help tags",
		},
		{
			"<leader>uc",
			function()
				-- live-preview on move, <CR> applies; config.theme persists the pick
				require("telescope.builtin").colorscheme({ enable_preview = true })
			end,
			desc = "Colorschemes (preview)",
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					prompt_position = "top",
				},
				sorting_strategy = "ascending",
			},
			pickers = {
				find_files = {
					hidden = true,
					file_ignore_patterns = { "%.git/" },
				},
				-- match find_files: let ripgrep search hidden files too (still skip .git)
				live_grep = {
					additional_args = function()
						return { "--hidden", "--glob", "!**/.git/*" }
					end,
				},
			},
		})
		pcall(require("telescope").load_extension, "fzf")

		local groups = {
			"TelescopeNormal",
			"TelescopeBorder",
			"TelescopePromptNormal",
			"TelescopePromptBorder",
			"TelescopePromptTitle",
			"TelescopeResultsNormal",
			"TelescopeResultsBorder",
			"TelescopeResultsTitle",
			"TelescopePreviewNormal",
			"TelescopePreviewBorder",
			"TelescopePreviewTitle",
		}
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end

		-- Colors follow the active colorscheme (nightfox)
		local c = require("nightfox.palette").load("nightfox")

		-- Titles: purple
		vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none", fg = c.magenta.base })
		vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "none", fg = c.magenta.base })
		vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "none", fg = c.magenta.base })

		-- Borders: blue
		vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = c.blue.base })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none", fg = c.blue.base })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none", fg = c.blue.base })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none", fg = c.blue.base })
	end,
}
