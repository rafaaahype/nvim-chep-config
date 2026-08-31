local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/nvim/site/java-workspaces/" .. project_name

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local config = {
  -- Executável nativo do Arch Linux
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
      -- Instrui o jdtls a tratar a pasta src/ como a raiz do código-fonte
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

-- Atalho para visualizar erros (E) e avisos (W) em janela flutuante
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = true, silent = true, desc = "Ver Erro/Aviso" })

-- Inicializa o servidor LSP
require("jdtls").start_or_attach(config)

-- Compilar e Executar Java (<F5>) gerando a pasta bin/ fora de src/
vim.keymap.set("n", "<F5>", function()
  vim.cmd("write")

  -- 1. Identifica a raiz do projeto (onde fica .git, pom.xml, etc.)
  local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
  if not root_dir or root_dir == "" then
    root_dir = vim.fn.expand("%:p:h")
  end

  -- 2. Detecta a declaração de package no arquivo atual
  local package_name = ""
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 15, false)) do
    local match = line:match("^%s*package%s+([%w_%.]+)%s*;")
    if match then
      package_name = match
      break
    end
  end

  -- 3. Monta o nome qualificado da classe (ex: com.rafael.game.Main)
  local class_name = vim.fn.expand("%:t:r")
  local full_class_name = (package_name ~= "") and (package_name .. "." .. class_name) or class_name

  -- 4. Verifica existência da pasta src/
  local src_dir = root_dir .. "/src"
  local has_src = vim.fn.isdirectory(src_dir) == 1

  local source_flag = has_src and "-sourcepath src" or ""
  local find_path = has_src and "src" or "."

  -- 5. Compila a partir da RAIZ do projeto e gera os .class dentro de bin/
  local cmd = string.format(
    "cd %q && mkdir -p bin && javac %s -d bin $(find %s -type f -name \"*.java\") && java -cp bin %s",
    root_dir,
    source_flag,
    find_path,
    full_class_name
  )

  -- 6. Executa no terminal integrado na parte inferior
  vim.cmd("botright 15new")
  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end, { buffer = true, silent = true, desc = "Compilar e Executar Java com Packages" })
