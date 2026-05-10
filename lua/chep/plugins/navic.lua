return {
  {
    "SmiteshP/nvim-navic",

    dependencies = {
      "neovim/nvim-lspconfig",
    },

    config = function()
      local navic = require("nvim-navic")

      navic.setup({
        highlight = true,
        separator = " > ",
        depth_limit = 5,
      })

      vim.o.winbar =
        "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },
}
