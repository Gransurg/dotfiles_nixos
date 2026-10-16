return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main", -- the supported branch for Neovim 0.11+/0.12 (master is legacy)
	build = ":TSUpdate",
	lazy = false,
	config = function()
		-- Install the parsers we use (async; a no-op if already installed).
		require("nvim-treesitter").install({
			"lua",
			"luadoc",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"typescript",
			"tsx",
			"python",
			"java",
			"bash",
			"css",
			"html",
			"markdown",
			"markdown_inline",
		})

		-- On the `main` branch highlighting/indent are no longer auto-enabled, so
		-- start them ourselves for any buffer whose filetype has a parser installed.
		vim.api.nvim_create_autocmd("FileType", {
			desc = "Enable treesitter highlighting + indentation",
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
