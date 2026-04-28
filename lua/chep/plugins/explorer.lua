  return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
        hijack_cursor = true,
        sync_root_with_cwd = true,
        view = { width = 30, adaptive_size = true },
      })
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
    end
  }
