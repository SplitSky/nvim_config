-- ~/.config/nvim/lua/plugins.lua

return {
	-- LSP Configuration & Autocompletion
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		config = function()
			require("lsp_config")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
	},

	-- Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"typescript",
					"javascript",
					"html",
					"css",
					"c",
					"cpp",
					"python",
					"rust",
					"go",
					"svelte",
					"markdown",
					"json",
					"yaml",
					"dockerfile",
					"graphql",
					"lua",
				},
				highlight = { enable = true },
			})
		end,
	},

	-- Utility Plugins
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
	},
	{
		"akinsho/toggleterm.nvim",
		event = "BufWinEnter",
	},

	-- Theme Plugins
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
	},
	{
		"catppuccin/nvim",
		lazy = false,
		opts = {},
	},

	-- Mason for managing LSP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"tsserver",
					"html",
					"cssls",
					"clangd",
					"pyright",
					"rust_analyzer",
					"gopls",
					"svelte",
					"jsonls",
					"yamlls",
					"dockerls",
					"graphql",
					"lua_ls",
				},
				automatic_installation = true,
			})
		end,
	},

	-- Markdown Preview
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
	},
}
