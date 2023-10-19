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
    bg = "#222131",
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
    fg = "#1e1d2d",
    bg = "#89b4fa",
  },
  SimpleDashButtons = {
    fg = "#d9e0ee",
    bg = "#252434",
  },
  SimpleDashFooter = {
    fg = "#89b4fa",
    bg = "#252434",
  },
}

return M
