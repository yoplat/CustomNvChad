---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "one_light" },
  transparency = false,

  hl_override = highlights.override,
  hl_add = highlights.add,

  extended_integrations = {
    "navic",
    "rainbowdelimiters",
    "trouble",
    "notify",
    "todo",
  }, -- NOTE: check what is already enabled

  statusline = {
    theme = "vscode_colored",
  },

  tabufline = {
    enabled = true,
  },

  lsp = {
    signature = false,
    semantic_tokens = false,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

require "custom.options"

return M
