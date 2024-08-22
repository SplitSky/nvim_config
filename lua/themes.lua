-- themes.lua
-- Enable true colors
vim.opt.termguicolors = true

if pcall(vim.cmd, "colorscheme gruvbox") then
  vim.opt.termguicolors = true
else
  vim.cmd("colorscheme default")
end
