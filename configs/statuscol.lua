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
    -- -- Only diasgnostics
    -- {
    --   sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
    --   click = "v:lua.ScSa",
    -- },
    -- { text = { " ", " ", builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
    -- -- Everything OTHER than diagnostics
    -- {
    --   sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
    --   click = "v:lua.ScSa",
    -- },
    -- Segment : Show signs with one character width
    {
      sign = {
        name = { ".*" },
        maxwidth = 1,
        colwidth = 1,
        auto = true,
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
