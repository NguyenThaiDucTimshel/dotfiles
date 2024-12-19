require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "zz", "<C-d>", { desc = "CMD enter command mode" })
map("n", "xx", "<C-u>", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Copy/paste from system clipboard
vim.keymap.set({ 'n', 'x' }, 'cp', '"+y')
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p')

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
