local M = {}

M.dapui = function(_, opts)
  local dap = require "dap"
  local dapui = require "dapui"
  dapui.setup(opts)
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open {}
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close {}
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close {}
  end
end

M.mason_dap = {
  automatic_installation = true,
  handlers = {},
  ensure_installed = {
    "debugpy",
  },
}

M.dap = function(_, _)
  dofile(vim.g.base46_cache .. "dap")
  local Config = require "custom.defaults"
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  for name, sign in pairs(Config.icons.dap) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define(
      "Dap" .. name,
      { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    )
  end
end

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

M.hydra = function(_, _)
  local hydra = require "hydra"
  hydra(dap_menu())
end

return M
