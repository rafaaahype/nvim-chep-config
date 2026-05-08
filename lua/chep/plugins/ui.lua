return {
  {
    "nvim-tree/nvim-web-devicons",

    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },

  {
    "sunjon/stylish.nvim",

    lazy = false,
    priority = 1000,

    config = function()
      require("stylish").setup()
    end,
  },

  {
    "catppuccin/nvim",

    name = "catppuccin",
    lazy = false,
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        transparent_background = true,

        integrations = {
          lualine = true,
          bufferline = true,
        },
      })

      vim.cmd.colorscheme("catppuccin")

      vim.cmd([[highlight IndentBlanklineIndent guifg=#313244]])
      vim.cmd([[highlight IndentBlanklineScope guifg=#f5c2e7]])
    end,
  },

  {
    "nvim-lualine/lualine.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin/nvim",
    },

    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("bufferline").setup({})

      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
      vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")
    end,
  },
}
