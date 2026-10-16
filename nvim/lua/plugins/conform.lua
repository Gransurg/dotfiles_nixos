return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			lua = { "stylua" },
			python = { "black" },
			sh = { "shfmt" },
		},
		format_on_save = {
			timeout_ms = 1500,
			lsp_format = "fallback",
		},
	},
}
