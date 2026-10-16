local keymap = vim.keymap.set

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = true, -- jagged lines for every severity (red errors, blue hints/info/warns)

	signs = false, -- no E/W letters in the sign column (keeps it for gitsigns only)
	virtual_text = false,
	virtual_lines = false,

	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = "cursor",
				focus = false,
			})
		end,
	},
})

keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Jump between diagnostics (uses jump.on_jump above to pop the float open)
keymap("n", "<leader>[", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })
keymap("n", "<leader>]", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Toggle diagnostics entirely
keymap("n", "<leader>ud", function()
	local enabled = vim.diagnostic.is_enabled()
	vim.diagnostic.enable(not enabled)
	vim.notify(enabled and "Diagnostics disabled" or "Diagnostics enabled")
end, { desc = "Toggle Diagnostics" })

-- Toggle inline diagnostics (virtual text at the end of each line)
keymap("n", "<leader>tt", function()
	local shown = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not shown })
	vim.notify(shown and "Inline diagnostics disabled" or "Inline diagnostics enabled")
end, { desc = "Toggle inline diagnostics" })

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- move things nicely in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selected lines down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selected lines up" })

-- Half page jumping with cursor in the same place
keymap("n", "<C-d>", "<C-d>zz", { desc = "Half page down stays centered" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Half page up stays centered" })

-- when using "/" to search this keeps the search term in the middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- This is to stop adding replaced text into clipboard
keymap("x", "<leader>p", '"_dP')

--del char w/o yank
keymap("n", "x", '"_x', { desc = "Delete char without yanking" })

--- Press <leader>d to see the full error in a pop-up
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Disable the command-line window accidental presses (q: and q?)
keymap("n", "q:", ":", { noremap = true })
keymap("n", "q?", ":", { noremap = true })

-- Also disable the visual command-line window
keymap("v", "q:", ":", { noremap = true })
