local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/nvim/site/java-workspaces/" .. project_name

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  -- Usa o executável nativo instalado pelo AUR no Arch
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
      -- Adicione este bloco para forçar o jdtls a entender a pasta src/ como raiz do código
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

-- Mapeamentos do LSP Java
local opts = { buffer = true, silent = true }
vim.keymap.set("n", "<leader>jo", require("jdtls").organize_imports, opts)
vim.keymap.set("n", "<leader>jc", vim.lsp.buf.code_action, opts)

-- Atalho para visualizar erros (E) e avisos (W) em popup flutuante
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = true, silent = true, desc = "Ver Erro/Aviso" })

-- Inicializa o servidor LSP
require("jdtls").start_or_attach(config)

-- Compilar e Executar Java (<F5>) com suporte a Packages
vim.keymap.set("n", "<F5>", function()
  vim.cmd("write")

  -- 1. Identifica a raiz do projeto e trata a estrutura src/
  local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
  if not root_dir or root_dir == "" then
    root_dir = vim.fn.expand("%:p:h")
  end

  local src_dir = root_dir .. "/src"
  local base_dir = vim.fn.isdirectory(src_dir) == 1 and src_dir or root_dir

  -- 2. Detecta a declaração de package no arquivo atual
  local package_name = ""
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 15, false)) do
    local match = line:match("^%s*package%s+([%w_%.]+)%s*;")
    if match then
      package_name = match
      break
    end
  end

  -- 3. Constrói a referência da classe qualificada (ex: com.rafael.game.Main)
  local class_name = vim.fn.expand("%:t:r")
  local full_class_name = (package_name ~= "") and (package_name .. "." .. class_name) or class_name

  -- 4. Compila todos os .java jogando a estrutura compilada dentro de bin/
  local cmd = string.format(
    "cd %q && mkdir -p bin && javac -d bin $(find . -type f -name \"*.java\") && java -cp bin %s",
    base_dir,
    full_class_name
  )

  -- 5. Executa no terminal em split
  vim.cmd("botright 15new")
  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end, { buffer = true, silent = true, desc = "Compilar e Executar Java com Packages" })
