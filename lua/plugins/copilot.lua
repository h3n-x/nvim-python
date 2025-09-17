-- ========================================================================================
-- GitHub Copilot Integration
-- AI-powered code completion and assistance
-- ========================================================================================

return {
  -- GitHub Copilot (DISABLED - using copilot.lua instead)
  {
    "github/copilot.vim",
    enabled = false,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
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
      {
        "<leader>ccp",
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
      -- Code related commands
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
      { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
      {
        "<leader>ccv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccx",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "CopilotChat - Run in-place code",
      },
      -- Custom input for CopilotChat
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
      -- Generate commit message based on the git diff
      {
        "<leader>ccm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Generate commit message for all changes",
      },
      {
        "<leader>ccM",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "CopilotChat - Generate commit message for staged changes",
      },
      -- Quick chat with Copilot
      {
        "<leader>ccq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd("CopilotChatBuffer " .. input)
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      -- Debug
      { "<leader>ccd", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
      -- Fix the issue with diagnostic
      { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
      -- Clear buffer and chat history
      { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
      -- Toggle Copilot Chat Vsplit
      { "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
    config = function()
      local colors = require("util.colors")
      
      require("CopilotChat").setup {
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",
        separator = " ", -- Separator to use in chat
        prompts = {
          -- Code related prompts
          Explain = "Please explain how the following code works.",
          Review = "Please review the following code and provide suggestions for improvement.",
          Tests = "Please explain how the selected code works, then generate unit tests for it.",
          Refactor = "Please refactor the following code to improve its clarity and readability.",
          FixCode = "Please fix the following code to make it work as intended.",
          FixError = "Please explain the error in the following text and provide a solution.",
          BetterNamings = "Please provide better names for the following variables and functions.",
          Documentation = "Please provide documentation for the following code.",
          SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
          SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
          -- Text related prompts
          Summarize = "Please summarize the following text.",
          Spelling = "Please correct any grammar and spelling errors in the following text.",
          Wording = "Please improve the grammar and wording of the following text.",
          Concise = "Please rewrite the following text to make it more concise.",
        },
        auto_follow_cursor = false, -- Don't follow the cursor after getting response
        show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
        mappings = {
          -- Use tab for completion
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          -- Close the chat
          close = {
            normal = "q",
            insert = "<C-c>"
          },
          -- Reset the chat buffer
          reset = {
            normal = "<C-x>",
            insert = "<C-x>"
          },
          -- Submit the prompt to Copilot
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-CR>"
          },
          -- Accept the diff
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>"
          },
          -- Yank the diff in the response to register
          yank_diff = {
            normal = "gmy",
          },
          -- Show the diff
          show_diff = {
            normal = "gmd"
          },
          -- Show the prompt
          show_system_prompt = {
            normal = "gmp"
          },
          -- Show the user selection
          show_user_selection = {
            normal = "gms"
          },
        },
        -- Custom selection
        selection = function(source)
          local select = require("CopilotChat.select")
          return select.visual(source) or select.buffer(source)
        end,
      }
      
      -- Custom highlights
      vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = colors.colors.color4, bold = true })
      vim.api.nvim_set_hl(0, "CopilotChatSeparator", { fg = colors.ui.border })
      vim.api.nvim_set_hl(0, "CopilotChatQuestion", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "CopilotChatAnswer", { fg = colors.colors.color2 })
      vim.api.nvim_set_hl(0, "CopilotChatError", { fg = colors.ui.error })
      vim.api.nvim_set_hl(0, "CopilotChatPrompt", { fg = colors.colors.color3 })
      vim.api.nvim_set_hl(0, "CopilotChatSpinner", { fg = colors.colors.color5 })
    end,
  },

  -- Copilot Lua (main engine)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    priority = 100, -- Higher priority to load before Avante
    config = function()
      require("copilot").setup({
        suggestion = { 
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-e>",
          },
        },
        panel = { enabled = false }, -- Disabled in favor of Avante
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
          python = true,
          lua = true,
          vim = true,
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
          -- Enable for Avante buffers
          Avante = true,
        },
        copilot_node_command = 'node',
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 10,
              inlineSuggestCount = 3,
            }
          },
        }
      })
      
      -- Integration with Avante
      vim.api.nvim_create_autocmd("User", {
        pattern = "AvanteOpened",
        callback = function()
          -- Ensure Copilot is enabled when Avante opens
          vim.cmd("Copilot enable")
        end,
      })
    end,
  },

  -- Modern Copilot CMP source (DISABLED to avoid conflicts)
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
  },
}
