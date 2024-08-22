-- plugins.lua

return require("packer").startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- LSP Configuration & Autocompletion
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("L3MON4D3/LuaSnip")

	-- Syntax Highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Fuzzy Finder
	use("nvim-telescope/telescope.nvim")

	-- Git integration
	use("tpope/vim-fugitive")

	-- Terminal integration
	use("akinsho/toggleterm.nvim")

	-- Additional plugins...
end)
