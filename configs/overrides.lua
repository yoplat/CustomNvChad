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
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- python
    "pyright",
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
      n = {
        ["q"] = require("telescope.actions").close,
      },
      i = {
        ["<esc>"] = require("telescope.actions").close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      },
    },
  },
}

M.nvterm = {
  terminals = {
    type_opts = {
      float = {
        relative = "editor",
        row = 0.2,
        col = 0.15,
        width = 0.7,
        height = 0.6,
        border = "single",
      },
      horizontal = { location = "rightbelow", split_ratio = 0.35 },
      vertical = { location = "rightbelow", split_ratio = 0.5 },
    },
  },
}

return M
