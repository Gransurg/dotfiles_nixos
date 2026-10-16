return {
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = {
			"html",
			"xml",
			"javascript",
			"javascriptreact",
			"jsx",
			"typescript",
			"typescriptreact",
			"tsx",
			"markdown",
		},
		opts = {
			opts = {
				enable_close = true, -- auto-close tags
				enable_rename = true, -- keep the pair in sync when you edit one side
				enable_close_on_slash = false,
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			progress = {
				suppress_on_insert = true,
				ignore_done_already = true,
				display = {
					render_limit = 1, -- max number of messages shown at once
					done_ttl = 3, -- how long a finished message lingers in seconds
				},
			},
		},
	},
	{
		"chentoast/marks.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			default_mappings = true,
			-- builtin marks shown in the gutter too (last insert, last change, etc.)
			builtin_marks = { ".", "<", ">", "^" },
			-- wrap around the buffer when jumping between marks
			cyclic = true,
			refresh_interval = 250,
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = true,
		keys = {
			{ "<m-h>", ":TmuxNavigateLeft<cr>", silent = true },
			{ "<m-j>", ":TmuxNavigateDown<cr>", silent = true },
			{ "<m-k>", ":TmuxNavigateUp<cr>", silent = true },
			{ "<m-l>", ":TmuxNavigateRight<cr>", silent = true },
			{ "<m-\\>", ":TmuxNavigatePrevious<cr>", silent = true },
		},
	},
}
