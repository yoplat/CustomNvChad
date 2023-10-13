---@type NvPluginSpec[]
local plugins = {
  -- TODO: checkout action-preview.nvim/codeactionmenu
  -- TODO: checkout lspsaga
  -- TODO: checkout stevearc/overseer.nvim
  -- TODO: checkout neogen
  -- TODO: checkout refactoring.nvim

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
    event = { "BufWrite" },
    opts = require "custom.configs.conform",
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        config = require("custom.configs.dap").dapui,
      },
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = require("custom.configs.dap").mason_dap,
      },
      {
        "anuvyklack/hydra.nvim",
        event = "LspAttach",
        config = require("custom.configs.dap").hydra,
      },
    },
    config = require("custom.configs.dap").dap,
  },
}

return plugins
