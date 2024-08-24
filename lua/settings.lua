-- ~/.config/nvim/lua/settings.lua

-- General editor settings
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.cursorline = true -- Highlight the current line
vim.opt.termguicolors = true -- Enable true color support

-- Function to set indentation based on file type
vim.cmd([[
  augroup SetIndent
    autocmd!
    autocmd FileType lua,svelte setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType python,yaml,json setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType c,cpp setlocal tabstop=2 shiftwidth=2 expandtab
    autocmd FileType make setlocal noexpandtab
  augroup END
]])
