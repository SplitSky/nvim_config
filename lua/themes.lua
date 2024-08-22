-- themes.lua
<<<<<<< HEAD
=======

-- Example: Set the colorscheme
vim.cmd("colorscheme tokyonight-night")

>>>>>>> 6cc1df3 (Added themes and plugins for handling issues)
-- Enable true colors
vim.opt.termguicolors = true

if pcall(vim.cmd, "colorscheme gruvbox") then
  vim.opt.termguicolors = true
else
  vim.cmd("colorscheme default")
end
