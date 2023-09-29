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

local override = function(modules)
  table.remove(modules, 10) -- Remove UTF-8

  modules[6] = (function() -- LSP progress messages
    local status = get_message()

    if not rawget(vim, "lsp") or vim.o.columns < 120 or not status then
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

  modules[11] = (function() -- LSP servers
    if rawget(vim, "lsp") then
      local lsp_status = ""
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
          lsp_status = lsp_status .. client.name .. " "
        end
      end
      return #lsp_status > 0
          and ((vim.o.columns > 100 and "%#St_LspStatus# 󰄭  [" .. lsp_status:sub(0, #lsp_status - 1) .. "] ") or "%#St_LspStatus# 󰄭  LSP  ")
        or ""
    end

    return ""
  end)()
end

return override
