return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "SmiteshP/nvim-navic",
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
      },
    })

    local capabilities =
      require("cmp_nvim_lsp").default_capabilities()

    local navic = require("nvim-navic")

    local function on_attach(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

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
      })

      vim.lsp.enable(server)
    end

    vim.lsp.config("arduino_language_server", {
      capabilities = capabilities,
      on_attach = on_attach,

      cmd = {
        "arduino-language-server",
        "-cli", "arduino-cli",
        "-clangd", "clangd",
        "-cli-config",
        vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
        "-fqbn", "arduino:avr:uno",
      },
    })

    vim.lsp.enable("arduino_language_server")

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  end,
}
