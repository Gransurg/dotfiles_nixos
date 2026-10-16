return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		cmdline = {
			view = "cmdline", -- bottom box, not a centered float
		},
		messages = {
			enabled = true,
			view = "mini",
			view_error = "mini",
			view_warn = "mini",
		},
		lsp = {
			hover = { enabled = false },
			signature = { enabled = false },
			progress = { enabled = false },
		},
	},
}
