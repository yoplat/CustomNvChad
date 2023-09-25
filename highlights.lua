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
  -- WinBar = {
  --   cterm = "none",
  --   gui = "none",
  -- },
}

vim.cmd "hi WinBar cterm=none gui=none"

---@type HLTable
M.add = {}

return M
