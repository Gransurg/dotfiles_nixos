-- autoread on buffer change
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	desc = "Reload file if changed on disk",
	command = "checktime",
})

-- Automatically make <Esc> close any floating windows (like LSP hover, mini.files)
vim.api.nvim_create_autocmd("WinEnter", {
	desc = "Close floating windows with Escape",
	callback = function()
		local win_config = vim.api.nvim_win_get_config(0)
		if win_config.relative ~= "" then
			vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = true, silent = true })
		end
	end,
})
