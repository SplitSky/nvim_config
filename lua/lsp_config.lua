-- lsp_config.lua

local lspconfig = require("lspconfig")

-- Python LSP
lspconfig.pyright.setup({})

-- TypeScript/JavaScript LSP
lspconfig.tsserver.setup({})

-- C++ LSP
lspconfig.clangd.setup({})

-- Svelte LSP
lspconfig.svelte.setup({})
