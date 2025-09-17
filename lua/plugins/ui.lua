-- ========================================================================================
-- Trouble and TODO Comments Configuration
-- Enhanced diagnostics and task management with Shades of Purple theme
-- ========================================================================================

return {
  -- Trouble.nvim - Better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      
      -- Custom highlights for Shades of Purple theme
      local colors = require("util.colors")
      
      local trouble_highlights = {
        TroubleNormal = { bg = colors.ui.bg_float, fg = colors.ui.fg_primary },
        TroubleNormalNC = { bg = colors.ui.bg_float, fg = colors.ui.fg_secondary },
        
        -- Text highlights
        TroubleText = { fg = colors.ui.fg_secondary },
        TroubleTextInformation = { fg = colors.ui.info },
        TroubleTextError = { fg = colors.ui.error },
        TroubleTextWarning = { fg = colors.ui.warning },
        TroubleTextHint = { fg = colors.ui.hint },
        
        -- Sign column
        TroubleSignError = { fg = colors.ui.error },
        TroubleSignWarning = { fg = colors.ui.warning },
        TroubleSignInformation = { fg = colors.ui.info },
        TroubleSignHint = { fg = colors.ui.hint },
        TroubleSignOther = { fg = colors.colors.color5 },
        
        -- Source highlights
        TroubleSource = { fg = colors.ui.fg_tertiary },
        TroubleCode = { fg = colors.colors.color6 },
        
        -- File and location
        TroubleFile = { fg = colors.colors.color4 },
        TroubleLocation = { fg = colors.ui.fg_tertiary },
        
        -- Count and icons
        TroubleCount = { fg = colors.colors.color3, bg = colors.ui.bg_secondary },
        TroubleIcon = { fg = colors.colors.color4 },
        
        -- Fold
        TroubleFoldIcon = { fg = colors.colors.color4 },
        
        -- Preview
        TroublePreview = { bg = colors.ui.bg_tertiary },
        
        -- Indent
        TroubleIndent = { fg = colors.ui.border },
        
        -- Position
        TroublePos = { fg = colors.ui.fg_inactive },
      }
      
      for group, opts_hl in pairs(trouble_highlights) do
        vim.api.nvim_set_hl(0, group, opts_hl)
      end
    end,
  },

  -- TODO Comments - Highlight and search for todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      signs = true, -- show icons in the signs column
      sign_priority = 8, -- sign priority
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = {
          icon = " ",
          color = "info",
          alt = { "todo" },
        },
        HACK = {
          icon = " ",
          color = "warning",
          alt = { "hack" },
        },
        WARN = {
          icon = " ",
          color = "warning",
          alt = { "WARNING", "XXX", "warning" },
        },
        PERF = {
          icon = "󰅒 ",
          color = "default",
          alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "performance" },
        },
        NOTE = {
          icon = " ",
          color = "hint",
          alt = { "INFO", "info", "note" },
        },
        TEST = {
          icon = "⏲ ",
          color = "test",
          alt = { "TESTING", "PASSED", "FAILED", "test" },
        },
      },
      gui_style = {
        fg = "NONE", -- The gui style to use for the fg highlight group.
        bg = "BOLD", -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines of context to show around a multiline comment
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#EC3A37" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FAD000" },
        info = { "DiagnosticInfo", "#9EFFFF" },
        hint = { "DiagnosticHint", "#6943FF" },
        default = { "Identifier", "#FB94FF" },
        test = { "Identifier", "#3AD900" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
      
      -- Custom highlights for Shades of Purple theme
      local colors = require("util.colors")
      
      local todo_highlights = {
        -- TODO
        TodoBgTODO = { fg = colors.colors.background, bg = colors.ui.info, bold = true },
        TodoFgTODO = { fg = colors.ui.info },
        TodoSignTODO = { fg = colors.ui.info },
        
        -- FIX
        TodoBgFIX = { fg = colors.colors.background, bg = colors.ui.error, bold = true },
        TodoFgFIX = { fg = colors.ui.error },
        TodoSignFIX = { fg = colors.ui.error },
        
        -- HACK
        TodoBgHACK = { fg = colors.colors.background, bg = colors.ui.warning, bold = true },
        TodoFgHACK = { fg = colors.ui.warning },
        TodoSignHACK = { fg = colors.ui.warning },
        
        -- WARN
        TodoBgWARN = { fg = colors.colors.background, bg = colors.ui.warning, bold = true },
        TodoFgWARN = { fg = colors.ui.warning },
        TodoSignWARN = { fg = colors.ui.warning },
        
        -- PERF
        TodoBgPERF = { fg = colors.colors.background, bg = colors.colors.color5, bold = true },
        TodoFgPERF = { fg = colors.colors.color5 },
        TodoSignPERF = { fg = colors.colors.color5 },
        
        -- NOTE
        TodoBgNOTE = { fg = colors.colors.background, bg = colors.ui.hint, bold = true },
        TodoFgNOTE = { fg = colors.ui.hint },
        TodoSignNOTE = { fg = colors.ui.hint },
        
        -- TEST
        TodoBgTEST = { fg = colors.colors.background, bg = colors.colors.color2, bold = true },
        TodoFgTEST = { fg = colors.colors.color2 },
        TodoSignTEST = { fg = colors.colors.color2 },
      }
      
      for group, opts_hl in pairs(todo_highlights) do
        vim.api.nvim_set_hl(0, group, opts_hl)
      end
      
      -- Add autocommands for better integration
      local augroup = vim.api.nvim_create_augroup("TodoComments", { clear = true })
      
      -- Refresh TODO comments when saving files
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = augroup,
        pattern = "*",
        callback = function()
          require("todo-comments").refresh()
        end,
      })
      
      -- Show TODO count in statusline (integration with lualine)
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
        group = augroup,
        pattern = "*",
        callback = function()
          -- Update statusline to reflect TODO count changes
          vim.cmd("redrawstatus")
        end,
      })
    end,
  },

  -- Project management with modern API (replacing project.nvim)
  {
    "nvim-telescope/telescope-project.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("project")
      
      -- Add project keymaps
      vim.keymap.set("n", "<leader>fp", "<cmd>Telescope project<cr>", { desc = "Projects" })
    end,
  },

  -- Inc-rename - Better LSP rename with preview
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
    keys = {
      {
        "<leader>cr",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename (inc-rename)",
      },
    },
    config = function(_, opts)
      require("inc_rename").setup(opts)
      
      -- Custom highlights
      local colors = require("util.colors")
      vim.api.nvim_set_hl(0, "IncRename", { fg = colors.colors.color3, bg = colors.ui.bg_secondary })
    end,
  },
}
