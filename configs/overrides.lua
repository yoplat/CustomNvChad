local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "bash",
    "cpp",
  },
  indent = {
    enable = true,
  },
}

-- git support in nvimtree
M.nvimtree = {
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<bs>", api.tree.change_root_to_parent, opts "Up")
    vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
    vim.keymap.set("n", ".", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "r", api.fs.rename_basename, opts "Rename")
    vim.keymap.set("n", "R", api.fs.rename, opts "Rename")
  end,
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
  },
}

M.telescope = {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
  extensions_list = { "zoxide", "themes", "terms", "fzf" },
}

return M
