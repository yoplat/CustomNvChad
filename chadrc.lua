---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "one_light" },
  transparency = false,
  lsp_semantic_tokens = false, -- Different syntax highlighting

  hl_override = highlights.override,
  hl_add = highlights.add,

  extended_integrations = {
    "navic",
    "rainbowdelimiters",
  }, -- NOTE: check what is already enabled

  statusline = {
    theme = "vscode_colored",
  },

  tabufline = {
    enabled = true,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

require "custom.options"

return M
