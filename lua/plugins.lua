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

  -- Additional plugins...
}

