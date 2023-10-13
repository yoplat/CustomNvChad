---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>qq"] = { "<cmd> qa <cr>", "Quit all" },
    ["<leader>qw"] = { "<cmd> q <cr>", "Quit Window" },
    ["<Esc>"] = { "<cmd>noh <CR>", "Clear highlights" },
    ["<leader>tt"] = { "<cmd> tabnext <cr>", "Next tab" },
    ["<leader>qt"] = { "<cmd> tabclose <cr>", "Tab close" },
    ["<leader>cc"] = { "<cmd> cd ~/.config/nvim/lua/custom <cr>", "Custom Config" },
    ["<leader>fm"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
  },

  t = {
    ["<C-h>"] = { "<C-\\><C-N><C-w>h", "Window Left" },
    -- ["<C-l>"] = { "<C-\\><C-N><C-w>l", "Window Right" }, -- Not enabled to clear the screen
    ["<C-j>"] = { "<C-\\><C-N><C-w>j", "Window Down" },
    ["<C-k>"] = { "<C-\\><C-N><C-w>k", "Window Up" },
  },
}

M.tabufline = {
  n = {
    ["<leader>x"] = {
      function()
        require("nvchad.tabufline").close_buffer()
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
  n = {
    ["<leader><leader>"] = { "<cmd> Telescope find_files <cr>", "Find Files" },
    ["<leader>fr"] = { "<cmd> Telescope oldfiles <cr>", "Recent Files" },
    ["<leader>fl"] = { "<cmd> Telescope highlights <cr>", "Find Highlights" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <cr>", "Find Keymaps" },
    ["<leader>fs"] = { "<cmd> Telescope persisted <cr>", "Find Sessions" },
    ["<leader>ft"] = { "<cmd> Telescope themes <cr>", "Find Themes" },
    ["<leader>fp"] = { "<cmd> Telescope zoxide list <cr>", "Find Projects" },
  },
}

M.nvimtree = {
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
  n = {
    ["gl"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
    ["<leader>cr"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP Rename",
    },
  },
}

M.trouble = {
  n = {
    ["gr"] = { "<cmd> TroubleToggle lsp_references <cr>", "Goto References" },
    ["ge"] = { "<cmd> TroubleToggle document_diagnostics <cr>", "File Diagnostics" },
    ["gt"] = { "<cmd> TodoTrouble <cr>", "Todo Trouble" },
    ["gd"] = { "<cmd> TroubleToggle lsp_definitions <cr>", "LSP Definition" },
  },
}

M.ufo = {
  n = {
    ["zR"] = {
      function()
        require("ufo").openAllFolds()
      end,
      "Open All Folds",
    },
    ["zM"] = {
      function()
        require("ufo").closeAllFolds()
      end,
      "Close All Folds",
    },
    ["zr"] = {
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      "Fold Less",
    },
    ["zm"] = {
      function()
        require("ufo").closeFoldsWith()
      end,
      "Fold More",
    },
    ["K"] = {
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      "Peek Fold",
    },
  },
}

M.neogit = {
  n = {
    ["<leader>gg"] = { "<cmd> Neogit <cr>", "Neogit" },
  },
}

M.gitsigns = {
  n = {
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
  },
}

M.persistence = {
  n = {
    ["<leader>qr"] = { [[<cmd>lua require("persistence").load({ last = true })<cr>]], "Load Last Session" },
  },
}

M.undotree = {
  n = {
    ["<leader>u"] = { "<cmd> UndotreeToggle <cr>", "Undo Tree" },
  },
}

M.dap = {
  -- stylua: ignore
  n = {
    ["<leader>du"] = { function() require("dapui").toggle({ }) end, "Dap UI" },
    ["<leader>de"] = { function() require("dapui").eval() end, "Eval" },
    ["<leader>dB"] = { function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Breakpoint Condition" },
    ["<leader>db"] = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
    ["<leader>dc"] = { function() require("dap").continue() end, "Continue" },
    ["<leader>dC"] = { function() require("dap").run_to_cursor() end, "Run to Cursor" },
    ["<leader>dg"] = { function() require("dap").goto_() end, "Go to line (no execute)" },
    ["<leader>di"] = { function() require("dap").step_into() end, "Step Into" },
    ["<leader>dj"] = { function() require("dap").down() end, "Down" },
    ["<leader>dk"] = { function() require("dap").up() end, "Up" },
    ["<leader>dl"] = { function() require("dap").run_last() end, "Run Last" },
    ["<leader>do"] = { function() require("dap").step_out() end, "Step Out" },
    ["<leader>dO"] = { function() require("dap").step_over() end,"Step Over" },
    ["<leader>dp"] = { function() require("dap").pause() end, "Pause" },
    ["<leader>dr"] = { function() require("dap").repl.toggle() end, "Toggle REPL" },
    ["<leader>ds"] = { function() require("dap").session() end, "Session" },
    ["<leader>dt"] = { function() require("dap").terminate() end, "Terminate" },
    ["<leader>dw"] = { function() require("dap.ui.widgets").hover() end, "Widgets" },
  },

  -- stylua: ignore
  v = {
    ["<leader>de"] = { function() require("dapui").eval() end, "Eval" },
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
    ["<leader>gs"] = false, -- Telescope Git Status
    ["<leader>td"] = false, -- Gitsigns Toggle Deleted
    ["<leader>th"] = false, -- Telescope themes
    ["<leader>cm"] = false, -- Telescope commits
    ["<leader>ch"] = false, -- Cheatsheet
    ["<leader>ma"] = false, -- Telescope bookmarks
    ["<leader>pt"] = false, -- Telescope terminals
    ["<leader>ra"] = false, -- Telescope terminals
    ["<leader>ph"] = false, -- Preview hunk
    ["<leader>rh"] = false, -- Reset hunk
    ["<leader>D"] = false, -- LSP type definition
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
