return function()
  local null_ls = require "null-ls"

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  null_ls.setup {
    sources = {
      -- null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.formatting.stylua,
      -- Python
      null_ls.builtins.formatting.usort, -- organize imports
      null_ls.builtins.formatting.black, -- formatter
      null_ls.builtins.diagnostics.ruff, -- linter
    },

    on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { async = false }
          end,
        })
      end
    end,
  }
end
