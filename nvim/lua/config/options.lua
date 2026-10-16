vim.loader.enable()

-- leader keys - must be first thing thats loaded in
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.have_nerd_font = true

-- vim.opt.guicursor = "n-v-c-i:block"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2 --tab size

vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"

vim.o.autoread = true
vim.opt.swapfile = false

vim.o.showmode = false -- dont show the mode since its in the statusline -> if no lualine then make true
vim.opt.fillchars = { eob = " " }

-- hand the bottom region (cmdline + messages) to noice, single global statusline (lualine)
vim.opt.cmdheight = 0
vim.opt.laststatus = 3

-- os and vim use same clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true
vim.o.wrap = false -- no line wrap

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.inccommand = "split" -- previews while making big multi line edits -> -- or 'nosplit', or '' to disable entirely

vim.o.splitright = true
vim.o.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

vim.o.confirm = true

vim.opt.termguicolors = true -- 24 bit color
