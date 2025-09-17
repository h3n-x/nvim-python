-- ========================================================================================
-- General Neovim Options
-- Optimized for development workflow and visual experience in Hyprland
-- ========================================================================================

local opt = vim.opt
local g = vim.g

-- ========================================================================================
-- Performance and Compatibility
-- ========================================================================================
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- ========================================================================================
-- UI and Appearance
-- ========================================================================================
opt.termguicolors = true              -- Enable 24-bit RGB colors
opt.background = "dark"               -- Dark background
opt.signcolumn = "yes"                -- Always show sign column
opt.cmdheight = 1                     -- Command line height
opt.pumheight = 10                    -- Popup menu height
opt.showmode = false                  -- Don't show mode in command line (lualine shows it)
opt.ruler = false                     -- Hide ruler (lualine shows position)
opt.laststatus = 3                    -- Global status line
opt.winminwidth = 5                   -- Minimum window width
opt.pumblend = 10                     -- Popup blend for transparency support in Hyprland
opt.winblend = 0                      -- Window blend

-- ========================================================================================
-- Line Numbers and Cursor
-- ========================================================================================
opt.number = true                     -- Show line numbers
opt.relativenumber = false            -- Disable relative line numbers
opt.cursorline = true                 -- Highlight current line
opt.cursorcolumn = false              -- Don't highlight current column (performance)

-- ========================================================================================
-- Indentation and Formatting
-- ========================================================================================
opt.expandtab = true                  -- Use spaces instead of tabs
opt.shiftwidth = 4                    -- Number of spaces for indentation
opt.tabstop = 4                       -- Number of spaces tabs count for
opt.softtabstop = 4                   -- Number of spaces for editing operations
opt.smartindent = true                -- Smart autoindenting
opt.autoindent = true                 -- Auto indenting
opt.breakindent = true                -- Wrap long lines with indent

-- ========================================================================================
-- Search and Replace
-- ========================================================================================
opt.ignorecase = true                 -- Ignore case in search
opt.smartcase = true                  -- Override ignorecase if search contains capitals
opt.hlsearch = true                   -- Highlight search matches
opt.incsearch = true                  -- Show search matches as you type
opt.inccommand = "nosplit"            -- Preview substitutions live

-- ========================================================================================
-- Completion and Wildmenu
-- ========================================================================================
opt.wildmode = "longest:full,full"    -- Command line completion mode
opt.completeopt = "menu,menuone,noselect" -- Completion options
opt.wildignore:append({
  "*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
  "*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/build/*",
  "*/node_modules/*", "*/.DS_Store"
})

-- ========================================================================================
-- File Handling
-- ========================================================================================
opt.hidden = true                     -- Allow buffer switching without saving
opt.autoread = true                   -- Auto reload files changed outside vim
opt.backup = false                    -- Don't create backup files
opt.writebackup = false               -- Don't create backup before overwriting
opt.swapfile = false                  -- Don't create swap files
opt.undofile = true                   -- Enable persistent undo
opt.undodir = vim.fn.stdpath("state") .. "/undo" -- Undo directory
opt.confirm = true                    -- Confirm before closing unsaved files

-- ========================================================================================
-- Splits and Windows
-- ========================================================================================
opt.splitbelow = true                 -- New horizontal splits below
opt.splitright = true                 -- New vertical splits to the right
opt.splitkeep = "screen"              -- Keep the screen when splitting

-- ========================================================================================
-- Scrolling and Mouse
-- ========================================================================================
opt.scrolloff = 8                     -- Lines to keep above/below cursor
opt.sidescrolloff = 8                 -- Characters to keep left/right of cursor
opt.mouse = "a"                       -- Enable mouse support
opt.mousemoveevent = true             -- Enable mouse move events

-- ========================================================================================
-- Timing and Performance
-- ========================================================================================
opt.updatetime = 200                  -- Faster completion and diagnostics
opt.timeoutlen = 300                  -- Time to wait for mapped sequence
opt.ttimeoutlen = 0                   -- Time to wait for key code sequence

-- ========================================================================================
-- Text Editing and Display
-- ========================================================================================
opt.wrap = false                      -- Don't wrap lines
opt.linebreak = true                  -- Wrap lines at convenient points
opt.textwidth = 0                     -- No automatic line breaking
opt.conceallevel = 0                  -- Don't hide concealed text
opt.concealcursor = ""                -- Don't conceal cursor line
opt.list = true                       -- Show invisible characters
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "␣"
}
opt.fillchars = {
  eob = " ",                          -- End of buffer
  fold = " ",
  foldopen = "▼",
  foldclose = "▶", 
  foldsep = "│",
  stl = " ",                          -- Status line
  stlnc = " ",                        -- Status line non-current window
}

-- ========================================================================================
-- Folding
-- ========================================================================================
opt.foldcolumn = "0"                  -- Hide fold column
opt.foldlevel = 99                    -- High fold level for initial view
opt.foldlevelstart = 99               -- Start with all folds open
opt.foldenable = true                 -- Enable folding
opt.foldmethod = "expr"               -- Use expression for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding

-- ========================================================================================
-- Clipboard and System Integration
-- ========================================================================================
if vim.fn.has("wsl") == 1 then
  opt.clipboard = "unnamedplus"
elseif vim.fn.has("unix") == 1 then
  opt.clipboard = "unnamedplus"       -- Use system clipboard on Linux/Hyprland
end

-- ========================================================================================
-- Session and View Options
-- ========================================================================================
opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds"
}
opt.viewoptions = {
  "folds",
  "options",
  "cursor",
  "unix",
  "slash"
}

-- ========================================================================================
-- Diff Options
-- ========================================================================================
opt.diffopt:append("iwhite")          -- Ignore whitespace in diff
opt.diffopt:append("algorithm:patience") -- Better diff algorithm
opt.diffopt:append("indent-heuristic") -- Better diff heuristic

-- ========================================================================================
-- Special Settings for Target Languages
-- ========================================================================================

-- Python specific
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    opt.tabstop = 4
    opt.shiftwidth = 4
    opt.softtabstop = 4
    opt.expandtab = true
  end,
})

-- YAML/TOML specific  
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml", "toml" },
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
  end,
})

-- JSON specific
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
    opt.conceallevel = 0
  end,
})

-- Markdown specific
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    opt.tabstop = 2
    opt.shiftwidth = 2
    opt.softtabstop = 2
    opt.expandtab = true
    opt.wrap = true
    opt.linebreak = true
    opt.breakindent = true
  end,
})

-- ========================================================================================
-- Font Configuration for Hyprland
-- ========================================================================================
if vim.fn.exists("g:neovide") == 1 then
  g.neovide_font_family = "JetBrainsMono Nerd Font"
  g.neovide_font_size = 12
  g.neovide_cursor_vfx_mode = "railgun"
  g.neovide_transparency = 0.95
elseif vim.fn.exists("g:fvim_loaded") == 1 then
  vim.api.nvim_exec2([[
    FVimFontLigature v:true
    FVimFontAntialias v:true
    FVimFontHintLevel 'full'
  ]], {})
end

-- Enable ligatures for terminal that support them
if vim.env.TERM_PROGRAM == "WezTerm" or vim.env.TERM_PROGRAM == "Alacritty" then
  vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
end

-- Desactiva la columna de números de línea en todos los buffers
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "WinEnter"}, {
  pattern = "*",
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = false
  end,
})
