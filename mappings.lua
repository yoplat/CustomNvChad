---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>q"] = { "<cmd> qa <cr>", "Quit all" },
    ["<Esc>"] = { "<cmd>noh <CR>", "Clear highlights" },
  },

  t = {
    ["<C-h>"] = { "<C-\\><C-N><C-w>h", "Window Left" },
    ["<C-l>"] = { "<C-\\><C-N><C-w>l", "Window Right" },
    ["<C-j>"] = { "<C-\\><C-N><C-w>j", "Window Down" },
    ["<C-k>"] = { "<C-\\><C-N><C-w>k", "Window Up" },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    ["<leader>x"] = {
      function()
        -- If there is only one window, act as close buffer
        if vim.fn.winbufnr(2) == -1 then
          require("nvchad.tabufline").close_buffer()
        -- Else, close window
        else
          vim.cmd "q"
        end
      end,
      "Close buffer",
    },
    ["L"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },
    ["H"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<leader><leader>"] = { "<cmd> Telescope find_files <cr>", "Find Files" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles <cr>", "Recent Files" },
    ["<leader>fl"] = { "<cmd> Telescope highlights <cr>", "Find Highlights" },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <cr>", "NvimTree" },
  },
}

M.lazy = {

  n = {
    ["<leader>l"] = { "<cmd> Lazy <cr>", "Lazy" },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["gl"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

M.trouble = {
  n = {
    ["gr"] = {
      function()
        require("trouble").open "lsp_references"
      end,
      "Goto references",
    },
    ["ge"] = {
      function()
        require("trouble").open "document_diagnostics"
      end,
      "File Diagnostics",
    },
    ["gt"] = { "<cmd> TodoTrouble <cr>", "Todo Trouble" },
  },
}

M.ufo = {
  plugin = true,

  n = {
    ["zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "Open all folds",
    },
    ["zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "Close all folds",
    },
  },
}

M.disabled = {
  n = {
    ["<leader>fo"] = false, -- Telescope oldfiles
    ["<leader>ff"] = false, -- Telescope find_files
    ["<leader>q"] = false, -- Diagnostics setloclist
    ["<C-n>"] = false, -- NvimTreeToggle
    ["<leader>ls"] = false, -- LSP signature help
    ["<leader>rn"] = false, -- Toggle relative numbers
    ["<leader>b"] = false, -- New buffer
    ["<leader>fm"] = false, -- Format
    ["<tab>"] = false, -- Next buffer
    ["<S-tab>"] = false, -- Next buffer
    ["<leader>n"] = false, -- Toggle line number
    ["<leader>/"] = false, -- Comment
    ["<leader>f"] = false, -- Floating diagnostic
    ["<leader>wK"] = false, -- WhickKey
    ["<leader>wk"] = false, -- WhichKey
    ["gr"] = false, -- Use trouble instead
    ["ge"] = false, -- Go to end
  },
  i = {
    ["<Tab>"] = false, -- Next buffer
    ["<S-Tab>"] = false, -- Next buffer
  },
  v = {
    ["<leader>/"] = false, -- Comment
  },
}

return M
