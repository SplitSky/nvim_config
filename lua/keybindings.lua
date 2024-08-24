-- ~/.config/nvim/lua/keybindings.lua

vim.g.mapleader = " " -- Space is the leader key

-- Telescope keybindings
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<CR>", { noremap = true, silent = true })

-- Terminal toggle
vim.api.nvim_set_keymap("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })
