return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "SmiteshP/nvim-navic",
    "mfussenegger/nvim-jdtls", -- Adicionado para suporte ao Java
  },

  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "html",
        "cssls",
        "ts_ls",
        "emmet_ls",
        "ols",
        "lua_ls",
        "arduino_language_server",
        "sqls",
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local navic = require("nvim-navic")

    local function on_attach(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
      
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    -- Definição explícita de propriedades para os servidores mandarem os argumentos
    local server_settings = {
      ts_ls = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          },
        },
      },
      lua_ls = {
        Lua = {
          hint = {
            enable = true,
            paramName = "All",
            paramType = true,
          },
        },
      },
    }

    -- Servidores genéricos
    local servers = {
      "clangd",
      "html",
      "cssls",
      "ts_ls",
      "emmet_ls",
      "ols",
      "lua_ls",
    }

    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = server_settings[server] or {},
      })
      vim.lsp.enable(server)
    end

    -- Arduino
    vim.lsp.config("arduino_language_server", {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "arduino-language-server",
        "-cli", "arduino-cli",
        "-clangd", "clangd",
        "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
        "-fqbn", "arduino:avr:uno",
      },
    })
    vim.lsp.enable("arduino_language_server")

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

    vim.keymap.set("n", "<M-,>", function()
      local current_buf = 0
      local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = current_buf })
      vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = current_buf })
    end, { desc = "Toggle Inlay Hints (Alt+,)" })
  end,
}

