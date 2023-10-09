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

-- Disable statusline on alpha buffer
vim.api.nvim_create_autocmd({ "UIEnter", "BufEnter" }, {
  group = augroup "add_statusline",
  callback = function()
    if vim.bo.filetype == "alpha" then
      vim.o.laststatus = 0
    else
      vim.o.laststatus = 3
    end
  end,
})

-- Enable colorcolumn after startup (no welcome screen)
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "colorcolumn",
  callback = function()
    vim.o.colorcolumn = "80"
  end,
  once = true, -- No need to run this every time
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

-- Terminal
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "BufEnter" }, {
  pattern = { "term://*" },
  callback = function()
    wo.signcolumn = "no"
    wo.cursorline = false
  end,
})
