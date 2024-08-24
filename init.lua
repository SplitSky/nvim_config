-- ~/.config/nvim/init.lua

-- Set up the leader key
vim.g.mapleader = " " -- Space is the leader key
vim.g.maplocalleader = " " -- Space is the local leader key

-- Ensure LazyVim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load LazyVim plugins and configurations
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})

-- Load additional configurations
require("settings")
require("keybindings")
require("autocmds")
require("lsp_config")
require("themes")
