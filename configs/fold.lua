local M = {}

M.ufo = {
  close_fold_kinds = { "imports" },
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
}

M.origami = {
  keepFoldsAcrossSessions = true,
  pauseFoldsOnSearch = true,
  setupFoldKeymaps = false,
}

return M
