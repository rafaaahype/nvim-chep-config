return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true, -- Ativa o plugin ao iniciar
      trigger_events = { "InsertLeave", "TextChanged" }, -- Salva ao sair do Insert ou mudar o texto
      -- Função que decide se deve salvar ou não
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        -- Não salva em tipos de arquivo especiais (NvimTree, Terminal, etc.)
        if fn.getbufvar(buf, "&buftype") ~= "" then
          return false
        end
        return true -- Salva nos arquivos normais
      end,
      write_all_buffers = false, -- Salva apenas o arquivo que você está mexendo
      debounce_delay = 135, -- Tempo de espera em milissegundos para salvar
    })
  end,
}
