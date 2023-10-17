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

return M
