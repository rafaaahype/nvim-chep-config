return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- setup do mason
      require("mason").setup()
      
      -- setup mason-lsp
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "html", "cssls", "ts_ls", "emmet_ls", "ols", "lua_ls" },
      })

      -- config servers
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = { "clangd", "html", "cssls", "ts_ls", "emmet_ls", "ols", "lua_ls" }
      
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- atalhos
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    end
  }
