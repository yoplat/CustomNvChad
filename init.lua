local wo = vim.wo -- window options
local o = vim.o

local function augroup(name)
  return vim.api.nvim_create_augroup("defaults_" .. name, { clear = true })
end

-- Show relative numbers in the active window, and absolute in others
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  pattern = { "^[term://*]" },
  callback = function()
    wo.relativenumber = false
    wo.number = true
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = { "^[term://*]" },
  callback = function()
    wo.relativenumber = true
    wo.number = true
  end,
})

-- Save and restore folds
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = augroup "save_folds",
  pattern = "*.*",
  callback = function()
    vim.cmd "mkview"
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup "restore_folds",
  pattern = "*.*",
  callback = function()
    vim.cmd "silent! loadview"
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

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
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
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "wrap_spell",
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
