---@type NvPluginSpec[]
local plugins = {

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
}

return plugins
