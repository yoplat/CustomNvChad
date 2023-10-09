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
  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- TODO: check when statuscolumn has updated to use extsigns
      _extmark_signs = false,
    },
  },
}

return plugins
