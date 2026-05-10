return {
  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>")

      vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
      vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
      vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>")
      vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>")
    end,
  },

  {
    "sindrets/diffview.nvim",
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },

    config = function()
      local neogit = require("neogit")

      neogit.setup({
        integrations = {
          diffview = true,
        },
      })

      vim.keymap.set("n", "<leader>gg", function()
        neogit.open()
      end, {
        desc = "Abrir Neogit",
      })

      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>")
      vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>")
    end,
  },
}
