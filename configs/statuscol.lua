local builtin = require "statuscol.builtin"

vim.opt.fillchars = {
  fold = " ",
  foldopen = " ",
  foldsep = " ",
  foldclose = "",
  stl = " ",
  eob = " ",
}

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
    "simple-dash",
  },
  segments = {
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
      text = { " ", " ", builtin.lnumfunc },
      click = "v:lua.ScLa",
      condition = { true, true, builtin.not_empty },
    },
    { text = { " " } },
  },
}
