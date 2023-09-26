local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

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

  -- override plugin configs
  {
    "NvChad/ui",
    pin = true,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
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

  -- Highlight current word and references
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter",
    config = function()
      local opts = require "custom.configs.illuminate"
      require("illuminate").configure(opts)
    end,
  },

  -- Rainbow paranthesis
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      dofile(vim.g.base46_cache .. "rainbowdelimiters")
    end,
  },

  -- Navic like winbar
  {
    "Bekaboo/dropbar.nvim",
    -- enabled = false,
    event = "BufReadPre",
    opts = require "custom.configs.dropbar",
  },

  -- Don't go over the 80 char
  {
    "Bekaboo/deadcolumn.nvim",
    event = "BufReadPost",
    opts = {},
  },

  -- TODO: comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = require "custom.configs.todo",
  },
}

return plugins
