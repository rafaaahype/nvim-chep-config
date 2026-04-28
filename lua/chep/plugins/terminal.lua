return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({ open_mapping = [[<C-t>]] })
    end
  },

  -- NEOGIT (Interface de Git)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({})

      -- Atalho: segura Ctrl, aperta g, solta tudo e aperta s
      vim.keymap.set("n", "<C-g>s", neogit.open, { desc = "Abrir Neogit" })
    end
  }
