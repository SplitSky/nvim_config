-- init.lua


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

-- Load LazyVim
require("lazy").setup("plugins")

-- Load core settings
require('settings')

-- Load keybindings
require('keybindings')

-- Load LSP configurations
require('lsp_config')

-- Load Autocommands
require('autocmds')

-- Load Themes and Appearance
require('themes')

-- Load language-specific configurations
require('languages.python')
require('languages.typescript')
require('languages.cpp')
require('languages.svelte')
