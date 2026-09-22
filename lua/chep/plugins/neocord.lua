return {
  "IogaMaster/neogit",
  event = "VeryLazy",
  config = function()
    require("neocord").setup({
      auto_update         = true,
      neovim_image_text   = "who is this diva",
      main_image          = "neovim",
      client_id           = "793271441293967371",
      log_level           = nil,
      debounce_timeout    = 10,
      enable_line_number  = false,
      blacklist           = {},
      buttons             = true,
      file_assets         = {},
      show_time           = true,

      editing_text        = "Codando %s",
      file_explorer_text  = "Navegando em %s",
      git_commit_text     = "Commitando alterações",
      plugin_manager_text = "Gerenciando plugins",
      reading_text        = "Lendo %s",
      workspace_text      = "Trabalhando em %s",
      line_number_text    = "Linha %d de %d",
    })
  end,
}
