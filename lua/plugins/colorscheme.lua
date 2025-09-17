-- ========================================================================================
-- Catppuccin Theme Configuration with Shades of Purple Customization
-- ========================================================================================

local colors = require("util.colors")

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- Base flavor: latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {
      mocha = {
        -- Override catppuccin colors with Shades of Purple palette
        rosewater = colors.colors.color5,  -- #FB94FF
        flamingo = colors.colors.color1,   -- #EC3A37
        pink = colors.colors.color5,       -- #FB94FF
        mauve = colors.colors.color4,      -- #6943FF
        red = colors.colors.color1,        -- #EC3A37
        maroon = colors.colors.color1,     -- #EC3A37
        peach = colors.colors.color3,      -- #FAD000
        yellow = colors.colors.color3,     -- #FAD000
        green = colors.colors.color2,      -- #3AD900
        teal = colors.colors.color6,       -- #9EFFFF
        sky = colors.colors.color14,       -- #80FCFF
        sapphire = colors.colors.color6,   -- #9EFFFF
        blue = colors.colors.color4,       -- #6943FF
        lavender = colors.colors.color12,  -- #7857FE
        text = colors.colors.foreground,   -- #FFFFFF
        subtext1 = colors.colors.color7,   -- #A599E9
        subtext0 = colors.ui.fg_secondary, -- #8B86C7
        overlay2 = colors.ui.fg_tertiary,  -- #6B6B8B
        overlay1 = colors.colors.color8,   -- #494685
        overlay0 = colors.ui.border,       -- #3A3866
        surface2 = colors.ui.bg_tertiary,  -- #262545
        surface1 = colors.ui.bg_secondary, -- #1F1E3A
        surface0 = colors.ui.bg_statusline, -- #1A1933
        base = colors.colors.background,   -- #191830
        mantle = colors.ui.bg_float,       -- #151424
        crust = colors.colors.color0,      -- #131327
      },
    },
    custom_highlights = function(C)
      return {
        -- ========================================================================================
        -- General UI
        -- ========================================================================================
        Normal = { bg = colors.colors.background, fg = colors.colors.foreground },
        NormalFloat = { bg = colors.ui.bg_float, fg = colors.colors.foreground },
        FloatBorder = { bg = colors.ui.bg_float, fg = colors.ui.border },
        FloatTitle = { bg = colors.ui.bg_float, fg = colors.colors.color4 },
        
        -- Cursor and selection
        Cursor = { bg = colors.colors.cursor, fg = colors.colors.background },
        CursorLine = { bg = colors.ui.cursor_line },
        CursorColumn = { bg = colors.ui.cursor_line },
        Visual = { bg = colors.ui.bg_visual },
        VisualNOS = { bg = colors.ui.bg_visual },
        
        -- Line numbers
        LineNr = { fg = colors.ui.fg_inactive },
        CursorLineNr = { fg = colors.colors.color3, style = { "bold" } },
        SignColumn = { bg = colors.colors.background },
        
        -- Folds
        Folded = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_tertiary },
        FoldColumn = { bg = colors.colors.background, fg = colors.ui.fg_inactive },
        
        -- Search
        Search = { bg = colors.ui.bg_search, fg = colors.colors.foreground },
        IncSearch = { bg = colors.colors.color3, fg = colors.colors.background },
        CurSearch = { bg = colors.colors.color3, fg = colors.colors.background },
        
        -- Statusline
        StatusLine = { bg = colors.ui.bg_statusline, fg = colors.ui.fg_secondary },
        StatusLineNC = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_inactive },
        
        -- Tabline
        TabLine = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_inactive },
        TabLineFill = { bg = colors.ui.bg_primary },
        TabLineSel = { bg = colors.colors.color4, fg = colors.colors.background },
        
        -- Popup menu
        Pmenu = { bg = colors.ui.bg_float, fg = colors.ui.fg_secondary },
        PmenuSel = { bg = colors.ui.selection, fg = colors.colors.foreground },
        PmenuSbar = { bg = colors.ui.bg_tertiary },
        PmenuThumb = { bg = colors.colors.color4 },
        
        -- Messages
        MsgArea = { fg = colors.ui.fg_secondary },
        ErrorMsg = { fg = colors.colors.color1 },
        WarningMsg = { fg = colors.colors.color3 },
        
        -- ========================================================================================
        -- Syntax Highlighting
        -- ========================================================================================
        Comment = { fg = colors.syntax.comment, style = { "italic" } },
        
        Constant = { fg = colors.syntax.constant },
        String = { fg = colors.syntax.string },
        Character = { fg = colors.syntax.character },
        Number = { fg = colors.syntax.number },
        Boolean = { fg = colors.syntax.boolean },
        Float = { fg = colors.syntax.number },
        
        Identifier = { fg = colors.syntax.variable },
        Function = { fg = colors.syntax["function"] },
        
        Statement = { fg = colors.syntax.keyword },
        Conditional = { fg = colors.syntax.conditional, style = { "italic" } },
        Repeat = { fg = colors.syntax.loop, style = { "italic" } },
        Label = { fg = colors.syntax.keyword },
        Operator = { fg = colors.syntax.operator },
        Keyword = { fg = colors.syntax.keyword },
        Exception = { fg = colors.syntax.exception },
        
        PreProc = { fg = colors.syntax.macro },
        Include = { fg = colors.syntax.keyword },
        Define = { fg = colors.syntax.macro },
        Macro = { fg = colors.syntax.macro },
        PreCondit = { fg = colors.syntax.macro },
        
        Type = { fg = colors.syntax.type },
        StorageClass = { fg = colors.syntax.keyword },
        Structure = { fg = colors.syntax.type },
        Typedef = { fg = colors.syntax.type },
        
        Special = { fg = colors.syntax.tag },
        SpecialChar = { fg = colors.syntax.string_escape },
        Tag = { fg = colors.syntax.tag },
        Delimiter = { fg = colors.syntax.delimiter },
        SpecialComment = { fg = colors.syntax.doc_comment },
        Debug = { fg = colors.syntax.macro },
        
        -- ========================================================================================
        -- Treesitter
        -- ========================================================================================
        ["@variable"] = { fg = colors.syntax.variable },
        ["@variable.builtin"] = { fg = colors.syntax.builtin },
        ["@variable.parameter"] = { fg = colors.syntax.parameter },
        ["@variable.member"] = { fg = colors.syntax.field },
        
        ["@constant"] = { fg = colors.syntax.constant },
        ["@constant.builtin"] = { fg = colors.syntax.constant },
        ["@constant.macro"] = { fg = colors.syntax.macro },
        
        ["@module"] = { fg = colors.syntax.type },
        ["@module.builtin"] = { fg = colors.syntax.builtin },
        
        ["@string"] = { fg = colors.syntax.string },
        ["@string.documentation"] = { fg = colors.syntax.doc_comment },
        ["@string.regexp"] = { fg = colors.syntax.string_escape },
        ["@string.escape"] = { fg = colors.syntax.string_escape },
        
        ["@character"] = { fg = colors.syntax.character },
        ["@character.special"] = { fg = colors.syntax.string_escape },
        
        ["@number"] = { fg = colors.syntax.number },
        ["@number.float"] = { fg = colors.syntax.number },
        
        ["@boolean"] = { fg = colors.syntax.boolean },
        
        ["@type"] = { fg = colors.syntax.type },
        ["@type.builtin"] = { fg = colors.syntax.builtin },
        ["@type.definition"] = { fg = colors.syntax.type },
        
        ["@attribute"] = { fg = colors.syntax.attribute },
        ["@property"] = { fg = colors.syntax.property },
        
        ["@function"] = { fg = colors.syntax["function"] },
        ["@function.builtin"] = { fg = colors.syntax.builtin },
        ["@function.call"] = { fg = colors.syntax["function"] },
        ["@function.macro"] = { fg = colors.syntax.macro },
        
        ["@function.method"] = { fg = colors.syntax.method },
        ["@function.method.call"] = { fg = colors.syntax.method },
        
        ["@constructor"] = { fg = colors.syntax.type },
        
        ["@conditional"] = { fg = colors.syntax.conditional, style = { "italic" } },
        ["@conditional.ternary"] = { fg = colors.syntax.operator },
        
        ["@repeat"] = { fg = colors.syntax.loop, style = { "italic" } },
        
        ["@label"] = { fg = colors.syntax.keyword },
        
        ["@keyword"] = { fg = colors.syntax.keyword },
        ["@keyword.function"] = { fg = colors.syntax.keyword },
        ["@keyword.operator"] = { fg = colors.syntax.operator },
        ["@keyword.return"] = { fg = colors.syntax.keyword },
        ["@keyword.exception"] = { fg = colors.syntax.exception },
        
        ["@operator"] = { fg = colors.syntax.operator },
        
        ["@exception"] = { fg = colors.syntax.exception },
        
        ["@punctuation.delimiter"] = { fg = colors.syntax.delimiter },
        ["@punctuation.bracket"] = { fg = colors.syntax.bracket },
        ["@punctuation.special"] = { fg = colors.syntax.delimiter },
        
        ["@comment"] = { fg = colors.syntax.comment, style = { "italic" } },
        ["@comment.documentation"] = { fg = colors.syntax.doc_comment },
        ["@comment.todo"] = { fg = colors.syntax.todo, bg = colors.ui.bg_secondary },
        
        ["@tag"] = { fg = colors.syntax.tag },
        ["@tag.attribute"] = { fg = colors.syntax.attribute },
        ["@tag.delimiter"] = { fg = colors.syntax.delimiter },
        
        -- ========================================================================================
        -- LSP
        -- ========================================================================================
        LspReferenceText = { bg = colors.ui.selection },
        LspReferenceRead = { bg = colors.ui.selection },
        LspReferenceWrite = { bg = colors.ui.selection },
        
        LspSignatureActiveParameter = { bg = colors.ui.cursor_line, style = { "bold" } },
        
        LspCodeLens = { fg = colors.ui.fg_inactive },
        LspCodeLensSeparator = { fg = colors.ui.border },
        
        -- ========================================================================================
        -- Diagnostics
        -- ========================================================================================
        DiagnosticError = { fg = colors.ui.error },
        DiagnosticWarn = { fg = colors.ui.warning },
        DiagnosticInfo = { fg = colors.ui.info },
        DiagnosticHint = { fg = colors.ui.hint },
        DiagnosticOk = { fg = colors.ui.git_add },
        
        DiagnosticVirtualTextError = { fg = colors.ui.error, bg = colors.darken(colors.ui.error, 90) },
        DiagnosticVirtualTextWarn = { fg = colors.ui.warning, bg = colors.darken(colors.ui.warning, 90) },
        DiagnosticVirtualTextInfo = { fg = colors.ui.info, bg = colors.darken(colors.ui.info, 90) },
        DiagnosticVirtualTextHint = { fg = colors.ui.hint, bg = colors.darken(colors.ui.hint, 90) },
        
        DiagnosticUnderlineError = { undercurl = true, sp = colors.ui.error },
        DiagnosticUnderlineWarn = { undercurl = true, sp = colors.ui.warning },
        DiagnosticUnderlineInfo = { undercurl = true, sp = colors.ui.info },
        DiagnosticUnderlineHint = { undercurl = true, sp = colors.ui.hint },
        
        -- ========================================================================================
        -- Git
        -- ========================================================================================
        DiffAdd = { bg = colors.darken(colors.ui.git_add, 85) },
        DiffChange = { bg = colors.darken(colors.ui.git_change, 85) },
        DiffDelete = { bg = colors.darken(colors.ui.git_delete, 85) },
        DiffText = { bg = colors.darken(colors.ui.git_change, 70) },
        
        -- ========================================================================================
        -- Plugin-specific customizations will be added by individual plugin configs
        -- ========================================================================================
      }
    end,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      -- Enable integrations for plugins we use
      dap = true,
      dap_ui = true,
      leap = false,
      markdown = true,
      mason = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      telescope = {
        enabled = true,
        style = "nvchad"
      },
      lsp_trouble = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    
    -- Apply terminal colors
    colors.apply_terminal_colors()
    
    -- Set colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}
