-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

--- Remove all trailing whitespace on save
-- autocmd("BufWritePre", {
--   command = [[:%s/\s\+$//e]],
--   group = augroup("TrimWhiteSpaceGrp", { clear = true }),
-- })