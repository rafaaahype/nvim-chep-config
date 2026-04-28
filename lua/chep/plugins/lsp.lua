return {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. Setup do Mason básico
      require("mason").setup()
      
      -- 2. Setup do Mason-Lspconfig (garante a instalação)
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "html", "cssls", "ts_ls", "emmet_ls" },
      })

      -- 3. Configuração dos servidores (Jeito clássico mas compatível)
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = { "clangd", "html", "cssls", "ts_ls", "emmet_ls" }
      
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- Atalhos
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    end
  }