return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local status, ts = pcall(require, "nvim-treesitter.configs")
    if not status then return end

    ts.setup({
      ensure_installed = { "javascript", "typescript", "html", "css", "c", "lua_ls", "ols" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    })
  end
}
