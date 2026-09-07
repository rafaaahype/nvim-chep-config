return {
  "VidocqH/lsp-lens.nvim",
  event = "BufReadPost",
  opts = {
    enable_variable_references = true,
    include_declaration = true,
    sections = {
      definition = true,
      references = true,
      implementation = true,
    },
  }
}
