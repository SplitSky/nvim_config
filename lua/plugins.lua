-- plugins.lua

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
    },
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    build = ":TSUpdate",
  },

  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = "Git",
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
  },
  -- Colour Scheme
  {
    "morhetz/gruvbox",
    config = function()
      vim.cmd("colorscheme gruvbox")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  --
  -- Mason for managing LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPconfig for integrating Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "tsserver", "clangd", "svelte" }, -- Add any other servers you need
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig for configuring LSP servers
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp_config")
    end,
  },

  -- Autocompletion setup
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },

}

