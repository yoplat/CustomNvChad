---@type NvPluginSpec[]
local plugins = {
  -- TODO: checkout action-preview.nvim/codeactionmenu

  -- Completition framework
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require "custom.configs.copilot"
        end,
      },
    },
    config = function(_, opts)
      require "custom.configs.cmp"(opts)
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead" },
    config = function() end, -- Override to make sure load order is correct
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = function(plugin, opts)
          local setup = require "custom.configs.lspconfig"
          setup.setup(plugin, opts)
          setup.setup_opts()
        end,
      },
      "williamboman/mason-lspconfig",
    },
  },

  -- formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "custom.configs.conform",
  },
}

return plugins
