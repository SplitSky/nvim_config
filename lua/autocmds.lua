-- autocmds.lua

-- Auto source Lua files on save
vim.cmd("autocmd BufWritePost *.lua source %")
vim.cmd("autocmd BufWritePost *.svelte source %")
-- Highlight yanked text
vim.cmd("autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual = false}")

-- Auto open quickfix window if there are errors
vim.cmd("autocmd QuickFixCmdPost [^l]* cwindow")
vim.cmd("autocmd QuickFixCmdPost l* lwindow")
