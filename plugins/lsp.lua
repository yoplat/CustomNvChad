---@type NvPluginSpec[]
local plugins = {
  -- TODO: checkout action-preview.nvim/codeactionmenu
  -- TODO: checkout lspsaga
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
          require "custom.configs.lsp.lspconfig"(plugin, opts)
          require "custom.configs.lsp.diagnostics"()
        end,
      },
      "williamboman/mason-lspconfig",
    },
  },

  -- None-ls: linting and formatting
  {
    "nvimtools/none-ls.nvim",
    event = "LspAttach",
    config = require "custom.configs.lsp.null",
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
    },
    config = require("custom.configs.dap").dap,
  },

  -- Compiler/Overseer: task runner
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = {
      {
        "stevearc/overseer.nvim",
        cmd = { "OverseerRun", "OverseerToggle" },
        opts = {
          templates = { "builtin" },
        },
      },
    },
    opts = {},
  },

  -- Vim-slime: Small utility to send code to a running REPL
  {
    -- <C-c> to send current line or selection
    -- <C-v> to set correct jobid (echo &channel)
    "jpalardy/vim-slime",
    keys = { "<C-c>" },
    config = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_default_config = { jobid = 3 }
    end,
  },

  -- ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT" },
    config = require "custom.configs.chat",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
}

return plugins
