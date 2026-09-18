return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "🛈", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "➔", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

    vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Debug: Alternar Breakpoint" })
    vim.keymap.set("n", "<leader><F8>", function() dap.toggle_breakpoint() end, { desc = "Debug: Alternar Breakpoint" })

    vim.keymap.set("n", "<leader>bc", function()
      vim.ui.input({ prompt = "Condição do Breakpoint: " }, function(input)
        if input then dap.set_breakpoint(input) end
      end)
    end, { desc = "Debug: Breakpoint Condicional" })

    vim.keymap.set("n", "<F9>", function() dap.continue() end, { desc = "Debug: Iniciar / Continuar" })
    vim.keymap.set("n", "<F8>", function() dap.step_over() end, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F7>", function() dap.step_into() end, { desc = "Debug: Step Into" })

    vim.keymap.set("n", "<S-F8>", function() dap.step_out() end, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<F20>", function() dap.step_out() end, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>so", function() dap.step_out() end, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<A-F8>", function() dapui.eval() end, { desc = "Debug: Avaliar Expressão" })
    vim.keymap.set("n", "<leader>e", function() dapui.eval() end, { desc = "Debug: Avaliar Expressão" })

    vim.keymap.set("n", "<leader>dq", function() dap.terminate() end, { desc = "Debug: Parar / Terminate" })
    vim.keymap.set("n", "<leader><F2>", function() dap.terminate() end, { desc = "Debug: Parar / Terminate" })

    local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(debugpy_path)

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
        name = "Lançar Executável",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.configurations.cpp = cpp_config
    dap.configurations.c = cpp_config
    dap.configurations.odin = cpp_config

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Lançar arquivo JS",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
  end,
}
