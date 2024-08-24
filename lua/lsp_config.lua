-- ~/.config/nvim/lua/lsp_config.lua

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Use Mason to automatically setup LSP servers
mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,

	["pyright"] = function()
		lspconfig.pyright.setup({
			-- Custom settings for Pyright, if needed
		})
	end,

	["tsserver"] = function()
		lspconfig.tsserver.setup({
			-- Custom settings for TSServer, if needed
		})
	end,

	["clangd"] = function()
		lspconfig.clangd.setup({
			-- Custom settings for Clangd, if needed
		})
	end,

	["svelte"] = function()
		lspconfig.svelte.setup({
			-- Custom settings for Svelte, if needed
		})
	end,

	["jsonls"] = function()
		lspconfig.jsonls.setup({})
	end,

	["yamlls"] = function()
		lspconfig.yamlls.setup({})
	end,

	["dockerls"] = function()
		lspconfig.dockerls.setup({})
	end,

	["graphql"] = function()
		lspconfig.graphql.setup({})
	end,
})
