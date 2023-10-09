local builtin = require "statuscol.builtin"

require("statuscol").setup {
  relculright = true,
  bt_ignore = { "nofile", "prompt", "terminal", "packer" },
  ft_ignore = {
    "NvimTree",
    "dashboard",
    "nvcheatsheet",
    "dapui_watches",
    "dap-repl",
    "dapui_console",
    "dapui_stacks",
    "dapui_breakpoints",
    "dapui_scopes",
    "help",
    "vim",
    "alpha",
    "dashboard",
    "neo-tree",
    "Trouble",
    "noice",
    "lazy",
    "toggleterm",
    "terminal",
  },
  segments = {
    -- TODO: check when statuscolumn has updated to use extsigns
    -- Show sign column
    {
      sign = {
        name = { ".*" },
        namespace = { "gitsigns" },
        maxwidth = 1,
        colwidth = 1,
        auto = false,
      },
      click = "v:lua.ScSa",
    },
    -- Segment: Show line number
    {
      text = { " ", " ", builtin.lnumfunc, " " },
      click = "v:lua.ScLa",
      condition = { true, builtin.not_empty },
    },
  },
}
