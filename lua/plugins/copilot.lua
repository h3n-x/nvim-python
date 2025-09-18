-- ========================================================================================
-- GitHub Copilot Integration
-- AI-powered code completion, assistance, and chat. All in one place.
-- ========================================================================================

return {
  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- Requerido por CopilotChat
      { "nvim-lua/plenary.nvim" },
    },
    keys = {
      {
        "<leader>ccc",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>cch",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      {
        "<leader>ccp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      {
        "<leader>cci",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "CopilotChat - Ask input",
      },
      { "<leader>ccm", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message" },
      { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and history" },
      { "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
    config = function()
      local colors = require("util.colors")
      require("CopilotChat").setup({
        -- ... (tu configuración de CopilotChat se mantiene igual)
        question_header = "## User ",
        answer_header = "## Copilot ",
        separator = " ",
        prompts = {
          Explain = "Please explain how the following code works.",
          Review = "Please review the following code and provide suggestions for improvement.",
          Tests = "Please explain how the selected code works, then generate unit tests for it.",
          Refactor = "Please refactor the following code to improve its clarity and readability.",
        },
        show_help = false,
        mappings = {
          complete = { insert = "<Tab>" },
          close = { normal = "q", insert = "<C-c>" },
          reset = { normal = "<C-x>", insert = "<C-x>" },
          submit_prompt = { normal = "<CR>", insert = "<C-CR>" },
          accept_diff = { normal = "<C-y>", insert = "<C-y>" },
        },
      })

      -- Custom highlights
      vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = colors.colors.color4, bold = true })
      vim.api.nvim_set_hl(0, "CopilotChatQuestion", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "CopilotChatAnswer", { fg = colors.colors.color2 })
    end,
  },

  -- Copilot Lua (motor principal) y Lógica de Integración
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    priority = 100,
    config = function()
      -- Configuración principal de copilot.lua
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-e>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          python = true,
          lua = true,
          javascript = true,
          typescript = true,
          css = true,
          scss = true,
          html = true,
          json = true,
          toml = true,
          bash = true,
          sh = true,
          sql = true,
          Avante = true,
        },
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 10,
              inlineSuggestCount = 3,
            },
          },
        },
      })

      -- ====================================================================
      -- LÓGICA DE INTEGRACIÓN
      -- ====================================================================

      -- Función para configurar autocmds para la integración de Copilot
      local function setup_copilot_integration()
        local augroup = vim.api.nvim_create_augroup("CopilotIntegration", { clear = true })

        -- Asegura que Copilot esté habilitado para los tipos de archivo soportados
        vim.api.nvim_create_autocmd("FileType", {
          group = augroup,
          pattern = {
            "python", "lua", "javascript", "typescript", "css", "scss", "html", "json", "yaml", "toml", "bash", "sh", "sql", "markdown",
          },
          callback = function()
            vim.b.copilot_enabled = true
          end,
        })

        -- Configura los highlights para las sugerencias de Copilot
        vim.api.nvim_create_autocmd("ColorScheme", {
          group = augroup,
          callback = function()
            local colors = require("util.colors")
            vim.api.nvim_set_hl(0, "CopilotSuggestion", {
              fg = colors.ui.fg_comment,
              italic = true,
            })
          end,
        })
      end

      -- Función para reiniciar Copilot si no está funcionando
      local function restart_copilot()
        vim.cmd("Copilot disable")
        vim.defer_fn(function()
          vim.cmd("Copilot enable")
          vim.notify("Copilot reiniciado", vim.log.levels.INFO)
        end, 1000)
      end

      -- Atajos de teclado globales para la gestión de Copilot
      vim.keymap.set('n', '<leader>cp', function() require("copilot.panel").open() end, { desc = "Panel de Copilot" })
      vim.keymap.set('n', '<leader>cpr', restart_copilot, { desc = "Reiniciar Copilot" })
      vim.keymap.set('n', '<leader>cps', function()
        local status = require("copilot.client").is_disabled() and "Inactivo" or "Activo"
        vim.notify("Estado de Copilot: " .. status, vim.log.levels.INFO)
      end, { desc = "Estado de Copilot" })
      vim.keymap.set('n', '<leader>ct', function() vim.cmd("Copilot toggle") end, { desc = "Toggle Copilot" })
      
      -- Atajo alternativo para aceptar sugerencias
      vim.keymap.set('i', '<C-l>', function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          -- Si no hay sugerencia, inserta el carácter literal <C-l> (salto de página)
          return vim.api.nvim_replace_termcodes('<C-l>', true, false, true)
        end
      end, { expr = true, desc = "Aceptar sugerencia de Copilot" })
      
      -- Inicializa la integración
      setup_copilot_integration()
    end,
  },
}
