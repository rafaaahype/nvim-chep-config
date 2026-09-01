return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true, 
      trigger_events = { "InsertLeave", "TextChanged" },
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if fn.getbufvar(buf, "&buftype") ~= "" then
          return false
        end
        return true
      end,
      write_all_buffers = false,
      debounce_delay = 135, 
    })
  end,
}
