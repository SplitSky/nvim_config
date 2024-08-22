-- keybindings.lua

vim.g.mapleader = " "

-- Save and quit bindings
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })

-- Telescope keybindings
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- Terminal toggle
vim.api.nvim_set_keymap("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
