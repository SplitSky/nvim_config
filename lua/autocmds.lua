-- ~/.config/nvim/lua/autocmds.lua

-- Auto source Lua and Svelte files on save
vim.cmd("autocmd BufWritePost *.lua source %")
vim.cmd("autocmd BufWritePost *.svelte source %")

-- Highlight yanked text
vim.cmd("autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual = false}")
