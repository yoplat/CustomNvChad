---@type NvPluginSpec[]
local plugins = {

  -- UI
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
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
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

  -- Navic like winbar
  {
    "Bekaboo/dropbar.nvim",
    -- enabled = false,
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

  -- Better folds
  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          require "custom.configs.statuscol"
        end,
      },
    },
    opts = {
      close_fold_kinds = { "imports" },
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
  },
}

return plugins
