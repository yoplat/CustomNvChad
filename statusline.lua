local M = {}
local fn = vim.fn

local get_message = function()
  local done = false
  for _, client in ipairs(vim.lsp.get_clients()) do
    for progress in client.progress do
      local value = progress.value
      if type(value) == "table" and value.kind then
        if value.kind == "end" then
          done = true
        end
        return {
          msg = value.message,
          title = value.title,
          percentage = value.percentage,
          done = done,
        }
      end
    end
  end
  return nil
end

M.statusline = function(modules)
  modules[6] = (function() -- LSP progress messages
    local status = get_message()

    if vim.o.columns < 120 or not status then
      return ""
    end

    if status.done then
      vim.defer_fn(function()
        vim.cmd.redrawstatus()
      end, 1000)
    end

    local msg = status.msg or ""
    local percentage = status.percentage or 100
    local title = status.title or ""
    local spinners = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
    -- Choose the frame based on the percentage
    local frame = percentage ~= 100 and math.floor(percentage * #spinners / 100) or 7
    local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

    return (status.msg or status.title) and ("%#St_LspProgress#" .. content) or ""
  end)()

  modules[9] = (function()
    return vim.o.columns > 140 and "%#StText# %l, %c  " or ""
  end)()

  modules[12] = (function() -- LSP servers
    local lsp_status = ""
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.attached_buffers[vim.api.nvim_get_current_buf()] then
        lsp_status = lsp_status .. client.name .. " "
      end
    end
    return #lsp_status > 0
        and ((vim.o.columns > 100 and "%#St_LspStatus# 󰄭  [" .. lsp_status:sub(0, #lsp_status - 1) .. "] ") or "%#St_LspStatus# 󰄭  LSP  ")
      or ""
  end)()

  table.remove(modules, 10) -- Remove UTF-8
  table.remove(modules, 8)
end

local tablist = function()
  local result, number_of_tabs = "", fn.tabpagenr "$"

  if number_of_tabs > 1 then
    for i = 1, number_of_tabs, 1 do
      local tab_hl = ((i == fn.tabpagenr()) and "%#TbLineTabOn# ") or "%#TbLineTabOff# "
      result = result .. ("%" .. i .. "@TbGotoTab@" .. tab_hl .. i .. " ")
      result = (i == fn.tabpagenr() and result .. "%#TbLineTabCloseBtn#" .. "%@TbTabClose@󰅙 %X") or result
    end

    return result
  end

  return ""
end

M.tabufline = function(modules)
  table.remove(modules, #modules)
  modules[3] = tablist()
end

return M
