---@type NvPluginSpec[]
local plugins = {

  -- TODO: checkout flatten.nvim
  -- TODO: checkout spectre.nvim
  -- TODO: checkout flash.nvim

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
    config = function()
      dofile(vim.g.base46_cache .. "todo")
      require("todo-comments").setup(require "custom.configs.todo")
    end,
  },

  -- Session manager
  {
    "olimorris/persisted.nvim",
    lazy = false,
    config = true,
  },

  -- Guess indent for file
  {
    "nmac427/guess-indent.nvim",
    event = "BufReadPre",
    opts = {},
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    cmd = "Neorg",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require "custom.configs.neorg",
  },
}

return plugins
