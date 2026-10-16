return {
	-- Better a/i text objects
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = {
			-- Provides the `textobjects.scm` query files (e.g. @function.outer) that mini.ai's treesitter spec reads.
			{ "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
		},
		config = function()
			local ai = require("mini.ai")
			local gen_spec = ai.gen_spec

			ai.setup({
				custom_textobjects = {
					-- Maps 'F' to the entire function definition via Treesitter.
					F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				},
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
			vim.keymap.set("i", "<CR>", "v:lua.MiniPairs.cr()", {
				-- makes enter in parenthesis send the closure one line below cursor so you don't end up with closing bracket on same line as cursor
				expr = true,
				replace_keycodes = false,
				desc = "MiniPairs <CR>",
			})
		end,
	},
}
