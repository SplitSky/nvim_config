-- ~/.config/nvim/lua/themes.lua

-- Try to set 'tokyonight-night' theme, fallback to 'catppuccin' and then default
if pcall(vim.cmd, "colorscheme tokyonight-night") then
	vim.opt.termguicolors = true
elseif pcall(vim.cmd, "colorscheme catppuccin") then
	vim.opt.termguicolors = true
else
	vim.cmd("colorscheme default")
end
