return {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update         = true,
        main_image          = "neovim",

        neovim_image_text   = "who is this diva?", 

        
        editing_text        = "Escrevendo %s", 
        workspace_text      = "Projeto: %s",
        file_explorer_text  = "Perdido no NvimTree",
        git_commit_text     = "Comitando mais uma gambiarra",
        plugin_manager_text = "Gerenciando os pluguinhos",
        reading_text        = "Lendo %s",
        line_number_text    = "Linha %s de %s"
      })
    end
  }
