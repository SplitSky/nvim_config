-- themes.lua

if pcall(vim.cmd, "colorscheme tokyonight-night") then
  vim.opt.termguicolors = true
else
  vim.cmd("colorscheme default")
end
