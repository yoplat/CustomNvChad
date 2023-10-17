return function(_, opts)
  dofile(vim.g.base46_cache .. "lsp")
  dofile(vim.g.base46_cache .. "mason")
  require "nvchad.lsp"

  local on_attach = require("plugins.configs.lspconfig").on_attach
  local capabilities = require("plugins.configs.lspconfig").capabilities

  -- List of servers to install
  local servers = {
    "html",
    "cssls",
    "tsserver",
    "clangd",
    "pyright",
    "bashls",
    "lua_ls",
  }

  -- List of tools to install (no servers)
  local ensure_installed = {
    "ruff",
    "black",
    "stylua",
    "debugpy",
  }

  require("mason").setup(opts)

  vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
  end, {})

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }

  local lspconfig = require "lspconfig"

  -- This will setup lsp for servers you listed above
  -- And servers you install through mason UI
  -- So defining servers in the list above is optional
  require("mason-lspconfig").setup_handlers {
    -- Default setup for all servers, unless a custom one is defined below
    function(server_name)
      lspconfig[server_name].setup {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          -- Add your other things here
          -- Example being format on save or something
        end,
        capabilities = (function()
          capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
          return capabilities
        end)(),
        -- capabilities = capabilities,
      }
    end,
    -- custom setup for a server goes after the function above
    -- Example, override rust_analyzer
    -- ["rust_analyzer"] = function ()
    --   require("rust-tools").setup {}
    -- end,
    -- Another example with clangd
    -- Users usually run into different offset_encodings issue,
    -- so this is how to bypass it (kindof)
    ["clangd"] = function()
      lspconfig.clangd.setup {
        cmd = {
          "clangd",
          "--offset-encoding=utf-16", -- To match null-ls
          --  With this, you can configure server with
          --    - .clangd files
          --    - global clangd/config.yaml files
          --  Read the `--enable-config` option in `clangd --help` for more information
          -- "--enable-config",
        },
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      }
    end,

    -- NOTE: Check for nvchad updates in plugins/configs/lspconfig.lua
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }
    end,
  }
end
