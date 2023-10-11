---@type NvPluginSpec[]
local plugins = {
  -- TODO: checkout hydra.nvim

  -- Dressing: better input and select
  {
    "stevearc/dressing.nvim", -- TODO: check if needs to be loaded earlier
    opts = function()
      return require("custom.configs.noice").dressing
    end,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  -- Noice: better ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          dofile(vim.g.base46_cache .. "notify")
          require("notify").setup(require("custom.configs.noice").notify)
        end,
      },
    },
    opts = function()
      return require("custom.configs.noice").noice
    end,
  },

  -- Dropbar: navic like winbar
  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPre",
    opts = require "custom.configs.dropbar",
  },

  -- Trouble: better diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      dofile(vim.g.base46_cache .. "trouble")
      local opts = require "custom.configs.trouble"
      require("trouble").setup(opts)
    end,
  },

  -- Statuscol: better statuscolumn
  {
    "luukvbaal/statuscol.nvim",
    event = "BufRead",
    config = function()
      require "custom.configs.statuscol"
    end,
  },

  -- SimpleDash: fast dashboard
  {
    dir = "~/SourcesGithub/SimpleDash",
    event = "VimEnter",
    opts = require "custom.configs.simpledash",
  },

  -- Ufo: better folds
  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "chrisgrieser/nvim-origami",
        opts = require("custom.configs.fold").origami,
      },
    },
    opts = require("custom.configs.fold").ufo,
  },
}

return plugins
