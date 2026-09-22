return {
  "mfussenegger/nvim-dap",
  lazy = false, -- CRÍTICO: Garante que o DAP exista antes do Java tentar usá-lo
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 1. Inicia a Interface
    dapui.setup()

    -- 2. Automação (Abrir/Fechar UI automaticamente)
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- 3. Símbolos visuais (Bolinha vermelha e seta)
    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "➔", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

    -- 4. Atalhos Universais
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<F9>", dap.continue, { desc = "Debug: Iniciar / Continuar" })
    vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<S-F8>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Parar / Terminate" })
    vim.keymap.set("n", "<leader>ui", dapui.toggle, { desc = "Debug: Alternar UI Manualmente" })

    -- ==================== C / C++ / ODIN ====================
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }
    local cpp_config = {
      {
        name = "Launch Executável",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Caminho do executável (ex: ./main): ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.c = cpp_config
    dap.configurations.cpp = cpp_config
    dap.configurations.odin = cpp_config

    -- ==================== PYTHON ====================
    local python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(python_path)

    -- ==================== JAVASCRIPT ====================
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" }
      }
    }
    dap.configurations.javascript = {
      { type = "pwa-node", request = "launch", name = "Rodar Arquivo JS", program = "${file}", cwd = "${workspaceFolder}" }
    }
  end,
}
