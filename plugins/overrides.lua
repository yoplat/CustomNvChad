local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  -- override plugin configs
  -- Mason
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "CmdLineEnter",
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
  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.indent,
  },
}

return plugins
