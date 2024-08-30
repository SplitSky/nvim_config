-- ~/.config/nvim/lua/cpp_config/cpp_setup.lua

-- Use the Lazy plugin manager to load plugins
require("lazy").setup({
	-- Plugin for Language Server Protocol (LSP) support
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({
				cmd = { "clangd", "--background-index" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
				settings = {
					clangd = {
						fallbackFlags = { "-std=c++17" },
					},
				},
			})
		end,
	},
	-- Plugin for autocompletion
	{
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-vsnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},
	-- Plugin for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "cpp" },
				highlight = {
					enable = true,
				},
			})
		end,
	},
})

-- Additional C++ specific settings
vim.opt.makeprg = "make" -- Set makeprg to use make
vim.opt.errorformat = "%f:%l:%c: %m" -- Set error format for quickfix
