local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/nvim/site/java-workspaces/" .. project_name

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  cmd = {
    "/usr/bin/jdtls",
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  capabilities = capabilities,
  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      project = {
        sourcePaths = { "src" },
      },
      completion = {
        importOrder = { "java", "javax", "com", "org" },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  init_options = {
    extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
  },
}

local opts = { buffer = true, silent = true }
vim.keymap.set("n", "<leader>jo", require("jdtls").organize_imports, opts)
vim.keymap.set("n", "<leader>jc", vim.lsp.buf.code_action, opts)

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = true, silent = true, desc = "Ver Erro/Aviso" })

require("jdtls").start_or_attach(config)

vim.keymap.set("n", "<F5>", function()
  vim.cmd("write")

  local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
  if not root_dir or root_dir == "" then
    root_dir = vim.fn.expand("%:p:h")
  end

  local package_name = ""
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 15, false)) do
    local match = line:match("^%s*package%s+([%w_%.]+)%s*;")
    if match then
      package_name = match
      break
    end
  end

  local class_name = vim.fn.expand("%:t:r")
  local full_class_name = (package_name ~= "") and (package_name .. "." .. class_name) or class_name

  local src_dir = root_dir .. "/src"
  local has_src = vim.fn.isdirectory(src_dir) == 1

  local source_flag = has_src and "-sourcepath src" or ""
  local find_path = has_src and "src" or "."

  local cmd = string.format(
    "cd %q && mkdir -p bin && javac %s -d bin $(find %s -type f -name \"*.java\") && java -cp bin %s",
    root_dir,
    source_flag,
    find_path,
    full_class_name
  )

  vim.cmd("botright 15new")
  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end, { buffer = true, silent = true, desc = "Compilar e Executar Java com Packages" })
