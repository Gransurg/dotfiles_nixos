-- QML (Qt / Quickshell) uses 4-space indentation, overriding the global 2-space
-- This also realigns snacks.nvim indent guides, which derive levels from shiftwidth.
-- default from lua/config/options.lua. Buffer-local, so only .qml files are affected.
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
