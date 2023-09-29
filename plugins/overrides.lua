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
  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.indent,
  },
}

return plugins
