-- ========================================================================================
-- DAP (Debug Adapter Protocol) Configuration
-- Debugging support for Python, Bash, and other languages
-- ========================================================================================

return {
  -- DAP Core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      local dap = require("dap")
      local colors = require("util.colors")
      
      -- Set up DAP signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◉", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "✘", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
      
      -- Custom highlights
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = colors.ui.error })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = colors.colors.color3 })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.colors.color2 })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = colors.darken(colors.colors.color3, 85) })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = colors.ui.error })
      
      -- Python configuration
      dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
              source_filetype = 'python',
            },
          })
        else
          cb({
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
            options = {
              source_filetype = 'python',
            },
          })
        end
      end
      
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return '/usr/bin/python'
            end
          end,
        },
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file with arguments',
          program = '${file}',
          args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
          end,
          console = 'integratedTerminal',
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return '/usr/bin/python'
            end
          end,
        },
        {
          type = 'python',
          request = 'attach',
          name = 'Attach remote',
          connect = function()
            local host = vim.fn.input('Host [127.0.0.1]: ')
            host = host ~= '' and host or '127.0.0.1'
            local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
            return { host = host, port = port }
          end,
        },
      }
      
      -- Bash configuration
      dap.adapters.bashdb = {
        type = 'executable',
        command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
        name = 'bashdb',
      }
      
      dap.configurations.sh = {
        {
          type = 'bashdb',
          request = 'launch',
          name = "Launch file",
          showDebugOutput = true,
          pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
          pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
          trace = true,
          file = "${file}",
          program = "${file}",
          cwd = '${workspaceFolder}',
          pathCat = "cat",
          pathBash = "/bin/bash",
          pathMkfifo = "mkfifo",
          pathPkill = "pkill",
          args = {},
          env = {},
          terminalKind = "integrated",
        }
      }
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
      
      -- Custom highlights
      local colors = require("util.colors")
      vim.api.nvim_set_hl(0, "DapUIVariable", { fg = colors.syntax.variable })
      vim.api.nvim_set_hl(0, "DapUIScope", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "DapUIType", { fg = colors.syntax.type })
      vim.api.nvim_set_hl(0, "DapUIValue", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = colors.colors.color3, bold = true })
      vim.api.nvim_set_hl(0, "DapUIDecoration", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "DapUIThread", { fg = colors.colors.color2 })
      vim.api.nvim_set_hl(0, "DapUIStoppedThread", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "DapUIFrameName", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "DapUISource", { fg = colors.colors.color5 })
      vim.api.nvim_set_hl(0, "DapUILineNumber", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "DapUIFloatBorder", { fg = colors.ui.border })
      vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { fg = colors.ui.error })
      vim.api.nvim_set_hl(0, "DapUIWatchesValue", { fg = colors.colors.color2 })
      vim.api.nvim_set_hl(0, "DapUIWatchesError", { fg = colors.ui.error })
      vim.api.nvim_set_hl(0, "DapUIBreakpointsPath", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "DapUIBreakpointsInfo", { fg = colors.colors.color2 })
      vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = colors.colors.color2, bold = true })
      vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "DapUIBreakpointsDisabledLine", { fg = colors.ui.fg_inactive })
    end,
  },

  -- Virtual Text
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup(opts)
      
      local colors = require("util.colors")
      vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = colors.ui.fg_tertiary, italic = true })
    end,
  },

  -- Mason DAP
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "python",
        "bash",
      },
    },
  },
}
