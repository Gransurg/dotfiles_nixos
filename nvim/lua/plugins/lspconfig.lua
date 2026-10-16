return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
					telemetry = { enabled = false },
				},
			},
		})

		-- Servers come from Nix (environment.systemPackages), NOT Mason:
		-- Mason ships generic-linux binaries that NixOS can't exec. vim.lsp.enable
		-- just turns on lspconfig's built-in defaults; each starts only if its
		-- binary is on PATH, so installing it in configuration.nix is what wires
		-- it up. Add/remove a name here to match what you install via Nix.
		vim.lsp.enable({
			"basedpyright",
			"clangd",
			"cssls",
			"gopls",
			"html",
			"jdtls",
			"lua_ls",
			"tailwindcss",
			"ts_ls",
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP keymaps",
			callback = function(event)
				local map = function(keys, fn, desc)
					vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", vim.lsp.buf.definition, "Goto definition")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action")

				-- Smart K: shows the diagnostic if the cursor is on one, otherwise docs.
				-- Press K again to jump into the float; q or <Esc> closes it.
				map("K", function()
					local line = vim.fn.line(".") - 1
					local col = vim.fn.col(".") - 1
					local diagnostics = vim.diagnostic.get(event.buf, { lnum = line })

					local on_diagnostic = false
					for _, d in ipairs(diagnostics) do
						if col >= d.col and col <= d.end_col then
							on_diagnostic = true
							break
						end
					end

					if on_diagnostic then
						vim.diagnostic.open_float({ border = "rounded", scope = "cursor" })
					else
						vim.lsp.buf.hover({ border = "rounded" })
					end
				end, "Hover / diagnostic (K again to enter, q/Esc to close)")
			end,
		})
	end,
}
