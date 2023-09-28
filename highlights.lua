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
}

vim.api.nvim_set_hl(0, "NoicePopup", { bg = "NONE" }) -- Cmp popup
vim.api.nvim_set_hl(0, "WinBar", { cterm = nil }) -- No dropbar bold font

---@type HLTable
M.add = {
  AlphaHeader = {
    fg = "blue",
  },
  AlphaButtons = {
    fg = "blue",
  },
  AlphaText = {
    fg = "teal",
  },
  AlphaFooter = {
    fg = "orange",
  },
}

return M
