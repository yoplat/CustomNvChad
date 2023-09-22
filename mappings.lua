---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.telescope = {
  plugin = true,
  n = {
    ["<leader><leader>"] = {"<cmd> Telescope find_files <cr>", "Find Files" },
    ["<leader>fr"] = {"<cmd> Telescope oldfiles <cr>", "Recent Files" },
  }
}

M.nvimtree = {
  plugin = true,
  n = {
    ["<leader>e"] = {"<cmd> NvimTreeToggle <cr>", "NvimTree" }
  }
}

-- Extras example
-- M.symbols_outline = {
--   n = {
--     ["<leader>cs"] = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
--   },
-- }

-- more keybinds!

return M
