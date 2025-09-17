-- ========================================================================================
-- Telescope Configuration - Fuzzy Finder
-- Enhanced with FZF native sorting and custom Shades of Purple theme
-- ========================================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>/", function() require("telescope.builtin").live_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", function() require("telescope.builtin").find_files() end, desc = "Find Files (Root Dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files (Root Dir)" },
      { "<leader>fF", function() require("telescope.builtin").find_files({ cwd = false }) end, desc = "Find Files (cwd)" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", function() require("telescope.builtin").oldfiles({ cwd = vim.uv.cwd() }) end, desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sg", function() require("telescope.builtin").live_grep() end, desc = "Grep (Root Dir)" },
      { "<leader>sG", function() require("telescope.builtin").live_grep({ cwd = false }) end, desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
      { "<leader>sw", function() require("telescope.builtin").grep_string({ word_match = "-w" }) end, desc = "Word (Root Dir)" },
      { "<leader>sW", function() require("telescope.builtin").grep_string({ cwd = false, word_match = "-w" }) end, desc = "Word (cwd)" },
      { "<leader>sw", function() require("telescope.builtin").grep_string() end, mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sW", function() require("telescope.builtin").grep_string({ cwd = false }) end, mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, desc = "Colorscheme with Preview" },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")
      local colors = require("util.colors")
      
      local open_with_trouble = function(...)
        return require("trouble.sources.telescope").open(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        require("telescope.builtin").find_files({ hidden = true, default_text = line })
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<c-t>"] = open_with_trouble,
              ["<a-t>"] = open_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
          winblend = 0,
          border = true,
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "__pycache__/",
            "%.pyc",
            "%.pyo",
            "%.DS_Store",
            "%.o",
            "%.obj",
            "%.exe",
            "%.dll",
            "%.so",
            "%.dylib",
            "%.jar",
            "%.zip",
            "%.tar%.gz",
            "%.7z",
            "%.rar",
          },
          dynamic_preview_title = true,
          results_title = false,
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            previewer = true,
            theme = "dropdown",
            layout_config = {
              width = 0.8,
              height = 0.6,
            },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob", "!**/.git/*" }
            end,
            previewer = true,
          },
          grep_string = {
            additional_args = function()
              return { "--hidden", "--glob", "!**/.git/*" }
            end,
            previewer = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            layout_config = {
              width = 0.6,
              height = 0.4,
            },
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          colorscheme = {
            enable_preview = true,
          },
          lsp_references = {
            theme = "dropdown",
            initial_mode = "normal",
          },
          lsp_definitions = {
            theme = "dropdown",
            initial_mode = "normal",
          },
          lsp_declarations = {
            theme = "dropdown",
            initial_mode = "normal",
          },
          lsp_implementations = {
            theme = "dropdown",
            initial_mode = "normal",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      
      -- Apply custom highlights
      local colors = require("util.colors")
      
      -- Telescope highlights with Shades of Purple theme
      local telescope_highlights = {
        TelescopeBorder = { fg = colors.ui.border },
        TelescopePromptBorder = { fg = colors.colors.color4 },
        TelescopeResultsBorder = { fg = colors.ui.border },
        TelescopePreviewBorder = { fg = colors.ui.border },
        
        TelescopePromptNormal = { bg = colors.ui.bg_secondary },
        TelescopeResultsNormal = { bg = colors.ui.bg_primary },
        TelescopePreviewNormal = { bg = colors.ui.bg_tertiary },
        
        TelescopePromptPrefix = { fg = colors.colors.color4 },
        TelescopePromptCounter = { fg = colors.colors.color3 },
        
        TelescopeSelection = { bg = colors.ui.selection, fg = colors.colors.foreground },
        TelescopeSelectionCaret = { fg = colors.colors.color4, bg = colors.ui.selection },
        
        TelescopeMatching = { fg = colors.colors.color3, bold = true },
        
        TelescopeTitle = { fg = colors.colors.color4, bold = true },
        TelescopePromptTitle = { fg = colors.colors.background, bg = colors.colors.color4, bold = true },
        TelescopeResultsTitle = { fg = colors.ui.fg_secondary },
        TelescopePreviewTitle = { fg = colors.colors.color5, bold = true },
        
        TelescopeResultsComment = { fg = colors.ui.fg_tertiary },
        TelescopeResultsSpecialComment = { fg = colors.ui.fg_tertiary },
        TelescopeResultsFunction = { fg = colors.syntax["function"] },
        TelescopeResultsMethod = { fg = colors.syntax.method },
        TelescopeResultsClass = { fg = colors.syntax.class },
        TelescopeResultsStruct = { fg = colors.syntax.type },
        TelescopeResultsVariable = { fg = colors.syntax.variable },
        TelescopeResultsConstant = { fg = colors.syntax.constant },
        TelescopeResultsOperator = { fg = colors.syntax.operator },
        TelescopeResultsKeyword = { fg = colors.syntax.keyword },
        TelescopeResultsString = { fg = colors.syntax.string },
        TelescopeResultsNumber = { fg = colors.syntax.number },
        TelescopeResultsBoolean = { fg = colors.syntax.boolean },
        
        TelescopePreviewLine = { bg = colors.ui.cursor_line },
        TelescopePreviewMatch = { bg = colors.ui.bg_search },
        
        TelescopeMultiSelection = { fg = colors.colors.color5 },
        TelescopeNormal = { bg = colors.ui.bg_float },
      }
      
      for group, opts in pairs(telescope_highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end,
  },
}
