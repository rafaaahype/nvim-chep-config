return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            " ",
            "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██║   ██║██║████╗ ████║",
            "██╔██╗ ██║██║   ██║██║██╔████╔██║",
            "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
            " ",
	    "o mito cria    o lixo copia ;p",
	    " ",
          },
          center = {
            { icon = "  ", desc = "Novo arquivo", action = "enew", key = "0" },
            { icon = "☭  ", desc = "Arquivos recentes", action = "Telescope oldfiles", key = "1" },
            { icon = "  ", desc = "Buscar arquivo", action = "Telescope find_files", key = "2" },
            { icon = "  ", desc = "Buscar texto", action = "Telescope live_grep", key = "3" },
            { icon = "(╯°□°)╯", desc = "Sair", action = "qa", key = "9" },
          },
          footer = function()
            local version = vim.version()
            local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local plugins = #vim.api.nvim_get_runtime_file("", true)

            return {
              "rafinha gameplays ltda",
              "chepware",
              "versao six seven",
              "projeto: " .. cwd,
              "pluguinhos: " .. plugins,
              "neovinho " .. version.major .. "." .. version.minor .. "." .. version.patch,
              "★ " .. os.date("%H:%M:%S"),
            }
          end
        }
      })
    end
  }
