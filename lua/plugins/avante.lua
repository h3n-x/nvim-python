-- ========================================================================================
-- Avante.nvim - AI Code Assistant Integration
-- Configured to use GitHub Copilot as the primary provider
-- ========================================================================================

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- ========================================================================================
    -- Core Configuration
    -- ========================================================================================
    debug = false,
    mode = "legacy", -- "agentic" | "legacy"
    provider = "copilot", -- Use GitHub Copilot as primary provider
    auto_suggestions_provider = "copilot", -- Use Copilot for auto-suggestions
    memory_summary_provider = "copilot", -- Use Copilot for memory summaries
    
    -- ========================================================================================
    -- Provider Configuration - GitHub Copilot Only
    -- ========================================================================================
    providers = {
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4o-2024-11-20",
        proxy = nil,
        allow_insecure = false,
        timeout = 120000, -- Increased from 60000 to 120000 (2 minutes)
        context_window = 64000,
        extra_request_body = {
          temperature = 0.3, -- Reduced from 0.75 to 0.3
          max_tokens = 20480,
        },
      },
    },
    
    -- ========================================================================================
    -- Behavior Configuration
    -- ========================================================================================
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = true, -- Enable auto-suggestions with Copilot
      auto_suggestions_respect_ignore = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      -- Enable automatic diff application for direct file editing
      auto_apply_diff_after_generation = true, -- Allow automatic changes
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = true,
      minimize_diff = false, -- Changed from true to false for clearer diffs
      enable_token_counting = true,
      use_cwd_as_project_root = true,
      auto_focus_on_diff_view = true,
      -- Enable automatic tool permissions for file editing
      auto_approve_tool_permissions = {
        "edit_file",
        "replace_in_file", 
        "create_file",
        "delete_file"
      }, -- Changed from true to specific permissions
      
      auto_check_diagnostics = true,
      enable_fastapply = true, -- Enable fast apply for better UX
      include_generated_by_commit_line = true,
    },
    
    -- ========================================================================================
    -- Key Mappings - Integrated with existing setup
    -- ========================================================================================
    mappings = {
      -- Diff navigation and resolution
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      
      -- Auto-suggestions
      suggestion = {
        accept = "<C-l>", -- Consistent with existing Copilot setup
        next = "<C-j>",
        prev = "<C-k>",
        dismiss = "<C-e>",
      },
      
      -- Navigation
      jump = {
        next = "]]",
        prev = "[[",
      },
      
      -- Submit and cancel
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      cancel = {
        normal = { "<C-c>", "<Esc>", "q" },
        insert = { "<C-c>" },
      },
      
      -- Main Avante commands - integrated with leader key setup
      ask = "<leader>aa",           -- Ask Avante
      new_ask = "<leader>an",       -- New ask session
      zen_mode = "<leader>az",      -- Zen mode
      edit = "<leader>ae",          -- Edit with Avante
      refresh = "<leader>ar",       -- Refresh
      focus = "<leader>af",         -- Focus sidebar
      stop = "<leader>aS",          -- Stop generation
      
      -- Toggle commands
      toggle = {
        default = "<leader>at",     -- Toggle Avante
        debug = "<leader>ad",       -- Toggle debug
        selection = "<leader>aC",   -- Toggle selection mode
        suggestion = "<leader>as",  -- Toggle suggestions
        repomap = "<leader>aR",     -- Toggle repo map
      },
      
      -- Sidebar navigation
      sidebar = {
        expand_tool_use = "<S-Tab>",
        next_prompt = "]p",
        prev_prompt = "[p",
        apply_all = "A",
        apply_cursor = "a",
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        toggle_code_window = "x",
        remove_file = "d",
        add_file = "@",
        close = { "q" },
      },
      
      -- File management
      files = {
        add_current = "<leader>ac",    -- Add current buffer
        add_all_buffers = "<leader>aB", -- Add all buffers
      },
      
      -- Model and history selection
      select_model = "<leader>a?",   -- Select model
      select_history = "<leader>ah", -- Select history
      
      -- Confirmation mappings
      confirm = {
        focus_window = "<C-w>f",
        code = "c",
        resp = "r",
        input = "i",
      },
    },
    
    -- ========================================================================================
    -- Window Configuration
    -- ========================================================================================
    windows = {
      position = "right", -- Sidebar on the right
      fillchars = "eob: ",
      wrap = true,
      width = 35, -- Slightly wider for better readability
      height = 30,
      
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
      
      input = {
        prefix = "> ",
        height = 8,
      },
      
      selected_files = {
        height = 6,
      },
      
      edit = {
        border = "rounded",
        start_insert = true,
      },
      
      ask = {
        floating = false,
        border = "rounded",
        start_insert = true,
        focus_on_apply = "ours",
      },
    },
    
    -- ========================================================================================
    -- Selection and Repository Configuration
    -- ========================================================================================
    selection = {
      enabled = true,
      hint_display = "delayed", -- Show hints after a delay
    },
    
    repo_map = {
      ignore_patterns = { 
        "%.git", "%.worktree", "__pycache__", "node_modules", 
        "%.pyc", "%.pyo", "%.DS_Store", "%.o", "%.obj"
      },
      negate_patterns = {},
    },
    
    -- ========================================================================================
    -- UI Integration - Use existing selectors
    -- ========================================================================================
    selector = {
      provider = "telescope", -- Use telescope for selections
      provider_opts = {},
    },
    
    input = {
      provider = "native",
      provider_opts = {},
    },
    
    file_selector = {
      provider = "telescope", -- Use telescope for file selection
      provider_opts = {},
    },
    
    -- ========================================================================================
    -- Suggestion Configuration
    -- ========================================================================================
    suggestion = {
      debounce = 400, -- Faster response for better UX
      throttle = 400,
    },
    
    -- ========================================================================================
    -- History and Logging
    -- ========================================================================================
    history = {
      max_tokens = 8192, -- Increased for better context
      storage_path = vim.fn.stdpath("state") .. "/avante",
      paste = {
        extension = "png",
        filename = "avante-paste-%Y-%m-%d-%H-%M-%S",
      },
    },
    
    prompt_logger = {
      enabled = true,
      log_dir = vim.fn.stdpath("cache") .. "/avante",
      max_entries = 100,
      next_prompt = {
        normal = "<C-n>",
        insert = "<C-n>",
      },
      prev_prompt = {
        normal = "<C-p>",
        insert = "<C-p>",
      },
    },
    
    -- ========================================================================================
    -- Diff Configuration
    -- ========================================================================================
    diff = {
      autojump = true,
      override_timeoutlen = 1000, -- Increased from 500 to 1000
      list_opener = "copen",
      debug = false,
    },
    
    -- ========================================================================================
    -- Custom Tools and Commands
    -- ========================================================================================
    custom_tools = {},
    slash_commands = {},
    shortcuts = {
      {
        name = "explain",
        key = "<leader>axe",
        desc = "Explain selected code",
        action = function()
          require("avante.api").ask({
            question = "Please explain this code in detail, including what it does, how it works, and any important patterns or concepts used.",
          })
        end,
      },
      {
        name = "optimize",
        key = "<leader>axo",
        desc = "Optimize selected code",
        action = function()
          require("avante.api").ask({
            question = "Please optimize this code for better performance, readability, and maintainability. Explain the improvements made.",
          })
        end,
      },
      {
        name = "test",
        key = "<leader>axt",
        desc = "Generate tests for code",
        action = function()
          require("avante.api").ask({
            question = "Generate comprehensive unit tests for this code, including edge cases and error scenarios.",
          })
        end,
      },
      {
        name = "document",
        key = "<leader>axd",
        desc = "Add documentation",
        action = function()
          require("avante.api").ask({
            question = "Add comprehensive documentation to this code, including docstrings, comments, and type hints where appropriate.",
          })
        end,
      },
      {
        name = "refactor",
        key = "<leader>axr",
        desc = "Refactor code",
        action = function()
          require("avante.api").ask({
            question = "Refactor this code to improve its structure, readability, and maintainability while preserving functionality.",
          })
        end,
      },
    },
  },
  
  -- ========================================================================================
  -- Plugin Dependencies
  -- ========================================================================================
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  
  -- ========================================================================================
  -- Configuration Function
  -- ========================================================================================
  config = function(_, opts)
    require("avante").setup(opts)
    
    -- Apply custom highlights with Shades of Purple theme
    local colors = require("util.colors")
    
    -- Avante-specific highlights
    local avante_highlights = {
      -- Sidebar
      AvanteSidebar = { bg = colors.ui.bg_sidebar, fg = colors.ui.fg_primary },
      AvanteTitle = { fg = colors.colors.color4, bold = true },
      AvanteReversedTitle = { bg = colors.colors.color4, fg = colors.colors.background, bold = true },
      AvanteSubtitle = { fg = colors.colors.color6, italic = true },
      AvanteReversedSubtitle = { bg = colors.colors.color6, fg = colors.colors.background },
      
      -- Input and prompts
      AvanteInput = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_primary },
      AvantePrompt = { fg = colors.colors.color3, bold = true },
      AvantePromptPrefix = { fg = colors.colors.color4, bold = true },
      
      -- Diff highlights
      AvanteDiffAdd = { bg = colors.darken(colors.ui.git_add, 85), fg = colors.ui.git_add },
      AvanteDiffDelete = { bg = colors.darken(colors.ui.git_delete, 85), fg = colors.ui.git_delete },
      AvanteDiffChange = { bg = colors.darken(colors.ui.git_change, 85), fg = colors.ui.git_change },
      AvanteDiffText = { bg = colors.darken(colors.ui.git_change, 70), fg = colors.colors.foreground },
      
      -- Code blocks
      AvanteCodeBlock = { bg = colors.ui.bg_tertiary },
      AvanteCodeBlockBorder = { fg = colors.ui.border },
      
      -- Messages and responses
      AvanteUserMessage = { fg = colors.colors.color6 },
      AvanteAssistantMessage = { fg = colors.colors.color2 },
      AvanteSystemMessage = { fg = colors.colors.color3, italic = true },
      AvanteError = { fg = colors.ui.error, bold = true },
      AvanteWarning = { fg = colors.ui.warning },
      AvanteInfo = { fg = colors.ui.info },
      
      -- Selection
      AvanteSelection = { bg = colors.ui.selection },
      AvanteSelectionBorder = { fg = colors.colors.color4 },
      
      -- Suggestions
      AvanteSuggestion = { fg = colors.ui.fg_tertiary, italic = true },
      AvanteSuggestionMatch = { fg = colors.colors.color3, bold = true },
      
      -- Spinner and loading
      AvanteSpinner = { fg = colors.colors.color5 },
      AvanteLoading = { fg = colors.colors.color4, italic = true },
      
      -- Borders and separators
      AvanteBorder = { fg = colors.ui.border },
      AvanteSeparator = { fg = colors.ui.border },
      
      -- File list
      AvanteFileList = { bg = colors.ui.bg_secondary },
      AvanteFileName = { fg = colors.colors.color4 },
      AvanteFileIcon = { fg = colors.colors.color6 },
      
      -- Tool use
      AvanteToolUse = { fg = colors.colors.color5, bold = true },
      AvanteToolOutput = { fg = colors.ui.fg_secondary },
    }
    
    for group, opts_hl in pairs(avante_highlights) do
      vim.api.nvim_set_hl(0, group, opts_hl)
    end
    
    -- Set up autocommands for better integration
    local augroup = vim.api.nvim_create_augroup("AvanteIntegration", { clear = true })
    
    -- Auto-focus Avante when opening
    vim.api.nvim_create_autocmd("User", {
      group = augroup,
      pattern = "AvanteOpened",
      callback = function()
        vim.notify("Avante AI Assistant activated", vim.log.levels.INFO)
      end,
    })
    
    -- Integration with existing LSP setup
    vim.api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      callback = function(event)
        -- Add Avante-specific keymaps when LSP attaches
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "Avante: " .. desc })
        end
        
        map("<leader>aL", function()
          require("avante.api").ask({
            question = "Explain the LSP diagnostics and suggest fixes for the current buffer.",
          })
        end, "Explain LSP diagnostics")
      end,
    })
    
    -- Python-specific integration
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "python",
      callback = function()
        vim.keymap.set("n", "<leader>aP", function()
          require("avante.api").ask({
            question = "Review this Python code for best practices, performance, and potential issues. Suggest improvements.",
          })
        end, { desc = "Avante: Python code review", buffer = true })
      end,
    })
    
    -- Markdown-specific integration
    vim.api.nvim_create_autocmd("FileType", {
      group = augroup,
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "<leader>aM", function()
          require("avante.api").ask({
            question = "Improve this markdown document's structure, clarity, and formatting.",
          })
        end, { desc = "Avante: Improve markdown", buffer = true })
      end,
    })
    
    -- Add debug logging to troubleshoot issues
    vim.api.nvim_create_user_command("AvanteDebug", function()
      vim.cmd("AvanteToggleDebug")
      print("Avante debug mode toggled")
    end, {})
    
    -- Add command to check Copilot status
    vim.api.nvim_create_user_command("AvanteCheckCopilot", function()
      local copilot_status = require("copilot.client").is_disabled()
      if copilot_status then
        print("Copilot is disabled - run :Copilot auth to authenticate")
      else
        print("Copilot is active and authenticated")
      end
    end, {})
  end,
}

