-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
  CursorLine = {
    bg = "lightbg",
  },
  PmenuSbar = {
    bg = "NONE",
    fg = "NONE",
  },
  PmenuThumb = {
    fg = "NONE",
    bg = "NONE",
  },
  FoldColumn = {
    bg = "NONE",
  },
}

vim.api.nvim_set_hl(0, "WinBar", { cterm = nil }) -- No dropbar bold font

M.add = {
  SimpleDashAscii = {
    fg = "#89b4fa",
    bg = "NONE",
  },
  SimpleDashButtons = {
    fg = "#d9e0ee",
    bg = "NONE",
  },
  SimpleDashFooter = {
    fg = "#89b4fa",
    bg = "NONE",
  },
}

return M
