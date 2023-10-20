local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  -- override plugin configs

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "CmdLineChanged",
    opts = overrides.treesitter,
  },

  -- Nvimtree
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- WhichKey
  {
    "folke/which-key.nvim",
    config = overrides.whichkey,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        norg = {
          icon = "",
          color = "#4878be",
          name = "neorg",
        },
      },
    },
  },
}

return plugins
