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
  FoldColumn = {
    bg = "NONE",
    fg = "sun",
  },
  PmenuSbar = {
    bg = "NONE",
    fg = "NONE",
  },
  PmenuThumb = {
    fg = "NONE",
    bg = "NONE",
  },
  -- Pmenu = {
  --   bg = "NONE",
  --   fg = "NONE",
  -- },
  NormalFloat = {
    bg = "NONE",
  },
}

vim.cmd "hi WinBar cterm=none gui=none"

---@type HLTable
M.add = {}

return M
