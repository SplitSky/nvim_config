
-- lsp_config.lua

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Use Mason to automatically setup LSP servers
mason_lspconfig.setup_handlers({
  -- Default handler (optional)
  function(server_name)
    lspconfig[server_name].setup({})
  end,

  -- You can override the default handler for specific servers if needed
  ["pyright"] = function()
    lspconfig.pyright.setup({
      -- Custom settings for Pyright
    })
  end,

  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      -- Custom settings for TypeScript server
    })
  end,

  ["ccls"] = function()
    lspconfig.ccls.setup({
      -- Custom settings for Clangd
    })
  end,

  ["svelte"] = function()
    lspconfig.svelte.setup({
      -- Custom settings for Svelte
    })
  end,
})

