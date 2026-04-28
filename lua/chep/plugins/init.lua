-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("chep.plugins.ui"),
  require("chep.plugins.dashboard"),
  require("chep.plugins.explorer"),
  require("chep.plugins.telescope"),
  require("chep.plugins.lsp"),
  require("chep.plugins.cmp"),
  require("chep.plugins.treesitter"),
  require("chep.plugins.terminal"),
  require("chep.plugins.git"),
  require("chep.plugins.presence"),
  require("chep.plugins.indent"),
  require("chep.plugins.autopairs"),
  require("chep.plugins.autotag"),
  require("chep.plugins.liveserver"),
})
