return {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    config = function()
      vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { silent = true, desc = "Start Live Server" })
      vim.keymap.set("n", "<leader>lS", ":LiveServerStop<CR>", { silent = true, desc = "Stop Live Server" })
    end
  }

