local M = {}

local function dap_menu()
  local dap = require "dap"
  local dapui = require "dapui"
  local dap_widgets = require "dap.ui.widgets"

  local hint = [[
 _t_: Toggle Breakpoint             _R_: Run to Cursor
 _s_: Start                         _E_: Evaluate Input
 _c_: Continue                      _C_: Conditional Breakpoint
 _b_: Step Back                     _U_: Toggle UI
 _d_: Disconnect                    _S_: Scopes
 _e_: Evaluate                      _X_: Close 
 _g_: Get Session                   _i_: Step Into 
 _h_: Hover Variables               _o_: Step Over 
 _r_: Toggle REPL                   _u_: Step Out
 _x_: Terminate                     _p_: Pause     
 ^ ^               _q_: Quit 
]]

  return {
    name = "Debug",
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        border = "rounded",
        position = "middle-right",
      },
    },
    mode = "n",
    body = "<A-d>",
    -- stylua: ignore
    heads = {
      { "C", function() dap.set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
      { "E", function() dapui.eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
      { "R", function() dap.run_to_cursor() end, desc = "Run to Cursor", },
      { "S", function() dap_widgets.scopes() end, desc = "Scopes", },
      { "U", function() dapui.toggle() end, desc = "Toggle UI", },
      { "X", function() dap.close() end, desc = "Quit", },
      { "b", function() dap.step_back() end, desc = "Step Back", },
      { "c", function() dap.continue() end, desc = "Continue", },
      { "d", function() dap.disconnect() end, desc = "Disconnect", },
      { "e", function() dapui.eval() end, mode = {"n", "v"}, desc = "Evaluate", },
      { "g", function() dap.session() end, desc = "Get Session", },
      { "h", function() dap_widgets.hover() end, desc = "Hover Variables", },
      { "i", function() dap.step_into() end, desc = "Step Into", },
      { "o", function() dap.step_over() end, desc = "Step Over", },
      { "p", function() dap.pause.toggle() end, desc = "Pause", },
      { "r", function() dap.repl.toggle() end, desc = "Toggle REPL", },
      { "s", function() dap.continue() end, desc = "Start", },
      { "t", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint", },
      { "u", function() dap.step_out() end, desc = "Step Out", },
      { "x", function() dap.terminate() end, desc = "Terminate", },
      { "q", nil, { exit = true, nowait = true, desc = "Exit" } },
    },
  }
end

local function window_menu()
  local splits = require "smart-splits"
  local cmd = require("hydra.keymap-util").cmd
  local pcmd = require("hydra.keymap-util").pcmd
  local window_hint = [[
  ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
  ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
  ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
  _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
  ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
  focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
  ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
  ]]
  return {
    name = "Windows",
    hint = window_hint,
    config = {
      invoke_on_body = true,
      hint = {
        border = "rounded",
        offset = -1,
      },
    },
    mode = "n",
    body = "<A-w>",
    heads = {
      { "h", "<C-w>h" },
      { "j", "<C-w>j" },
      { "k", pcmd("wincmd k", "E11", "close") },
      { "l", "<C-w>l" },

      { "H", cmd "WinShift left" },
      { "J", cmd "WinShift down" },
      { "K", cmd "WinShift up" },
      { "L", cmd "WinShift right" },

      {
        "<C-h>",
        function()
          splits.resize_left(2)
        end,
      },
      {
        "<C-j>",
        function()
          splits.resize_down(2)
        end,
      },
      {
        "<C-k>",
        function()
          splits.resize_up(2)
        end,
      },
      {
        "<C-l>",
        function()
          splits.resize_right(2)
        end,
      },
      { "=", "<C-w>=", { desc = "equalize" } },

      { "s", pcmd("split", "E36") },
      { "<C-s>", pcmd("split", "E36"), { desc = false } },
      { "v", pcmd("vsplit", "E36") },
      { "<C-v>", pcmd("vsplit", "E36"), { desc = false } },

      { "w", "<C-w>w", { exit = true, desc = false } },
      { "<C-w>", "<C-w>w", { exit = true, desc = false } },

      { "z", cmd "WindowsMaximaze", { exit = true, desc = "maximize" } },
      { "<C-z>", cmd "WindowsMaximaze", { exit = true, desc = false } },

      { "o", "<C-w>o", { exit = true, desc = "remain only" } },
      { "<C-o>", "<C-w>o", { exit = true, desc = false } },

      { "c", pcmd("close", "E444") },
      { "q", pcmd("close", "E444"), { desc = "close window" } },
      { "<C-c>", pcmd("close", "E444"), { desc = false } },
      { "<C-q>", pcmd("close", "E444"), { desc = false } },

      { "<Esc>", nil, { exit = true, desc = false } },
    },
  }
end

vim.g.hydra_dap = false
vim.g.hydra_window = false

M.dap = function()
  if not vim.g.hydra_dap then
    local hydra = require "hydra"
    hydra(dap_menu()):activate()
    vim.g.hydra_dap = true
  end
end

M.window = function()
  if not vim.g.hydra_window then
    local hydra = require "hydra"
    hydra(window_menu()):activate()
    vim.g.hydra_window = true
  end
end

return M
