-- ========================================================================================
-- Catppuccin Mocha Color Palette Utilities
-- Based on the official Catppuccin Mocha palette
-- ========================================================================================

local M = {}

-- ========================================================================================
-- Color Definitions (Catppuccin Mocha)
-- ========================================================================================

M.colors = {
  -- Special colors
  background = "#1e1e2e", -- Base
  foreground = "#cdd6f4", -- Text
  cursor = "#f5e0dc",     -- Rosewater (soft cursor)

  -- Standard colors (0-15)
  color0  = "#181825", -- Mantle
  color1  = "#f38ba8", -- Red
  color2  = "#a6e3a1", -- Green
  color3  = "#f9e2af", -- Yellow
  color4  = "#89b4fa", -- Blue
  color5  = "#cba6f7", -- Mauve
  color6  = "#94e2d5", -- Teal
  color7  = "#bac2de", -- Subtext1
  color8  = "#6c7086", -- Overlay0
  color9  = "#eba0ac", -- Maroon
  color10 = "#a6e3a1", -- Bright Green (same as green)
  color11 = "#fab387", -- Peach
  color12 = "#74c7ec", -- Sapphire
  color13 = "#b4befe", -- Lavender
  color14 = "#89dceb", -- Sky
  color15 = "#ffffff", -- Pure white
}

-- ========================================================================================
-- Semantic Color Aliases for UI Components
-- ========================================================================================

M.ui = {
  -- Background variants
  bg_primary    = M.colors.background,
  bg_secondary  = "#181825", -- Mantle
  bg_tertiary   = "#11111b", -- Crust
  bg_float      = "#1e1e2e", -- Base
  bg_sidebar    = "#181825", -- Mantle
  bg_statusline = "#313244", -- Surface0
  bg_visual     = "#45475a", -- Surface1
  bg_search     = "#585b70", -- Surface2

  -- Foreground variants
  fg_primary   = M.colors.foreground,
  fg_secondary = "#a6adc8", -- Subtext0
  fg_tertiary  = "#9399b2", -- Overlay2
  fg_inactive  = "#7f849c", -- Overlay1
  fg_comment   = "#6c7086", -- Overlay0

  -- Accent colors
  red     = "#f38ba8",
  maroon  = "#eba0ac",
  peach   = "#fab387",
  yellow  = "#f9e2af",
  green   = "#a6e3a1",
  teal    = "#94e2d5",
  sky     = "#89dceb",
  sapphire= "#74c7ec",
  blue    = "#89b4fa",
  lavender= "#b4befe",
  mauve   = "#cba6f7",
  pink    = "#f5c2e7",
  flamingo= "#f2cdcd",
  rosewater= "#f5e0dc",

  -- Border colors
  border = "#585b70", -- Surface2
  border_highlight = "#89b4fa", -- Blue

  -- Selection colors
  selection   = "#45475a", -- Surface1
  cursor_line = "#313244", -- Surface0

  -- Git colors
  git_add    = "#a6e3a1",
  git_change = "#f9e2af",
  git_delete = "#f38ba8",

  -- Diagnostic colors
  error   = "#f38ba8",
  warning = "#f9e2af",
  info    = "#89dceb",
  hint    = "#b4befe",
}

-- ========================================================================================
-- Syntax Highlighting Colors
-- ========================================================================================

M.syntax = {
  -- Keywords and language constructs
  keyword     = M.ui.mauve,
  conditional = M.ui.mauve,
  loop        = M.ui.mauve,
  exception   = M.ui.red,
  operator    = M.ui.pink,

  -- Functions and methods
  ["function"] = M.ui.blue,
  method       = M.ui.blue,
  builtin      = M.ui.teal,

  -- Variables and identifiers
  variable  = M.colors.foreground,
  parameter = M.ui.rosewater,
  field     = M.ui.pink,

  -- Types and classes
  type      = M.ui.yellow,
  class     = M.ui.yellow,
  interface = M.ui.yellow,
  enum      = M.ui.yellow,

  -- Constants and literals
  constant  = M.ui.peach,
  number    = M.ui.peach,
  boolean   = M.ui.red,
  string    = M.ui.green,
  string_escape = M.ui.teal,
  character = M.ui.green,

  -- Comments and documentation
  comment     = M.ui.fg_comment,
  doc_comment = M.ui.fg_tertiary,
  todo        = M.ui.yellow,

  -- Punctuation and delimiters
  punctuation = M.ui.fg_secondary,
  bracket     = M.ui.fg_secondary,
  delimiter   = M.ui.fg_secondary,

  -- Special
  tag       = M.ui.mauve,
  attribute = M.ui.teal,
  property  = M.ui.teal,
  url       = M.ui.sapphire,
  macro     = M.ui.pink,

  -- Markup (Markdown)
  markup_heading = M.ui.blue,
  markup_bold    = M.ui.yellow,
  markup_italic  = M.ui.mauve,
  markup_code    = M.ui.green,
  markup_link    = M.ui.teal,
  markup_quote   = M.ui.fg_secondary,
  markup_list    = M.ui.blue,
}

-- ========================================================================================
-- Plugin-Specific Color Schemes
-- ========================================================================================

M.plugins = {
  telescope = {
    border    = M.ui.border,
    selection = M.ui.selection,
    prompt    = M.ui.bg_secondary,
    results   = M.ui.bg_primary,
    preview   = M.ui.bg_tertiary,
    title     = M.ui.blue,
    matching  = M.ui.yellow,
  },

  lualine = {
    normal = {
      a = { bg = M.ui.blue, fg = M.colors.background, gui = "bold" },
      b = { bg = M.ui.bg_secondary, fg = M.ui.blue },
      c = { bg = M.ui.bg_statusline, fg = M.ui.fg_secondary },
    },
    insert = {
      a = { bg = M.ui.green, fg = M.colors.background, gui = "bold" },
      b = { bg = M.ui.bg_secondary, fg = M.ui.green },
    },
    visual = {
      a = { bg = M.ui.mauve, fg = M.colors.background, gui = "bold" },
      b = { bg = M.ui.bg_secondary, fg = M.ui.mauve },
    },
    replace = {
      a = { bg = M.ui.red, fg = M.colors.background, gui = "bold" },
      b = { bg = M.ui.bg_secondary, fg = M.ui.red },
    },
    command = {
      a = { bg = M.ui.yellow, fg = M.colors.background, gui = "bold" },
      b = { bg = M.ui.bg_secondary, fg = M.ui.yellow },
    },
  },

  nvim_tree = {
    bg          = M.ui.bg_sidebar,
    folder      = M.ui.blue,
    folder_open = M.ui.lavender,
    file        = M.ui.fg_secondary,
    exec        = M.ui.green,
    symlink     = M.ui.teal,
    git_dirty   = M.ui.yellow,
    git_staged  = M.ui.green,
    git_untracked = M.ui.red,
    indent      = M.ui.border,
  },

  which_key = {
    border    = M.ui.border,
    group     = M.ui.blue,
    desc      = M.ui.fg_secondary,
    key       = M.ui.yellow,
    separator = M.ui.fg_tertiary,
  },

  trouble = {
    bg      = M.ui.bg_float,
    fg      = M.ui.fg_primary,
    error   = M.ui.error,
    warning = M.ui.warning,
    info    = M.ui.info,
    hint    = M.ui.hint,
  },

  dap = {
    breakpoint   = M.ui.red,
    stopped      = M.ui.yellow,
    current_line = M.ui.cursor_line,
  },

  gitsigns = {
    add    = M.ui.git_add,
    change = M.ui.git_change,
    delete = M.ui.git_delete,
  },

  todo_comments = {
    error   = M.ui.red,
    warning = M.ui.yellow,
    info    = M.ui.info,
    hint    = M.ui.hint,
    default = M.ui.mauve,
    test    = M.ui.green,
  },
}

-- ========================================================================================
-- Color Manipulation Functions
-- ========================================================================================

function M.hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return {
    r = tonumber(hex:sub(1, 2), 16),
    g = tonumber(hex:sub(3, 4), 16),
    b = tonumber(hex:sub(5, 6), 16),
  }
end

function M.rgb_to_hex(r, g, b)
  return string.format("#%02X%02X%02X", r, g, b)
end

function M.lighten(color, percentage)
  local rgb = M.hex_to_rgb(color)
  local factor = 1 + (percentage / 100)
  rgb.r = math.min(255, math.floor(rgb.r * factor))
  rgb.g = math.min(255, math.floor(rgb.g * factor))
  rgb.b = math.min(255, math.floor(rgb.b * factor))
  return M.rgb_to_hex(rgb.r, rgb.g, rgb.b)
end

function M.darken(color, percentage)
  local rgb = M.hex_to_rgb(color)
  local factor = 1 - (percentage / 100)
  rgb.r = math.max(0, math.floor(rgb.r * factor))
  rgb.g = math.max(0, math.floor(rgb.g * factor))
  rgb.b = math.max(0, math.floor(rgb.b * factor))
  return M.rgb_to_hex(rgb.r, rgb.g, rgb.b)
end

function M.blend(color1, color2, alpha)
  local rgb1 = M.hex_to_rgb(color1)
  local rgb2 = M.hex_to_rgb(color2)
  local r = math.floor(rgb1.r * (1 - alpha) + rgb2.r * alpha)
  local g = math.floor(rgb1.g * (1 - alpha) + rgb2.g * alpha)
  local b = math.floor(rgb1.b * (1 - alpha) + rgb2.b * alpha)
  return M.rgb_to_hex(r, g, b)
end

-- ========================================================================================
-- Export Functions
-- ========================================================================================

function M.get_colors()
  return vim.tbl_deep_extend("force", M.colors, M.ui, M.syntax)
end

function M.get_plugin_colors(plugin_name)
  return M.plugins[plugin_name] or {}
end

function M.apply_terminal_colors()
  local g = vim.g

  g.terminal_color_0  = M.colors.color0
  g.terminal_color_1  = M.colors.color1
  g.terminal_color_2  = M.colors.color2
  g.terminal_color_3  = M.colors.color3
  g.terminal_color_4  = M.colors.color4
  g.terminal_color_5  = M.colors.color5
  g.terminal_color_6  = M.colors.color6
  g.terminal_color_7  = M.colors.color7
  g.terminal_color_8  = M.colors.color8
  g.terminal_color_9  = M.colors.color9
  g.terminal_color_10 = M.colors.color10
  g.terminal_color_11 = M.colors.color11
  g.terminal_color_12 = M.colors.color12
  g.terminal_color_13 = M.colors.color13
  g.terminal_color_14 = M.colors.color14
  g.terminal_color_15 = M.colors.color15

  g.terminal_color_background = M.colors.background
  g.terminal_color_foreground = M.colors.foreground
end

return M
