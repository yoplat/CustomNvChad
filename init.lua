local wo = vim.wo -- window options

local function augroup(name)
  return vim.api.nvim_create_augroup("defaults_" .. name, { clear = true })
end

-- NOTE: Update statusline on LSP progress (until nvchad updates)
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function()
    vim.cmd "redrawstatus"
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_filetype_with_q",
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "chatgpt-input",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = augroup "close_buf_with_q",
--   callback = function(event)
--     -- vim.notify(vim.bo[event.buf].buftype)
--     vim.notify(vim.api.nvim_buf_get_name(event.buf))
--     -- if vim.bo[event.buf].buftype == "nofile" then
--     --   -- vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
--     -- end
--   end,
-- })

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "wrap_spell",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup "statusline_terminal",
  callback = function()
    vim.cmd [[setlocal listchars= nonumber norelativenumber cursorline nocul]]
  end,
})
