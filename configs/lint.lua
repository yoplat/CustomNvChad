return function()
  require("lint").linters_by_ft = {
    -- python = { "ruff", "mypy" },
  }

  vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })
end
