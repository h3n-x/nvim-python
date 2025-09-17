-- ========================================================================================
-- Which-Key Configuration
-- Helps remember keybindings by showing available keys in a popup
-- ========================================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    delay = 300,
    win = {
      border = "rounded",
      padding = { 1, 2 },
      wo = {
        winblend = 10,
      },
    },
    layout = {
      width = { min = 20, max = 50 },
      spacing = 3,
    },
    triggers = {
      { "<auto>", mode = "nixsotc" },
    },
    spec = {
      -- Global groups
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>cc", group = "copilot" },
        { "<leader>d", group = "debug" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>l", group = "lazy" },
        { "<leader>m", group = "markdown" },
        { "<leader>o", group = "open" },
        { "<leader>q", group = "quit/session" },
        { "<leader>r", group = "run/execute" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "terminal/toggle" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
      },
      
      -- Buffer management
      { "<leader>bb", desc = "Switch to Other Buffer" },
      { "<leader>bc", desc = "Close Current Buffer" },
      { "<leader>bd", desc = "Delete Buffer" },
      { "<leader>bD", desc = "Delete Buffer (Force)" },
      { "<leader>bf", desc = "First Buffer" },
      { "<leader>bl", desc = "Last Buffer" },
      { "<leader>bn", desc = "Next Buffer" },
      { "<leader>bp", desc = "Previous Buffer" },
      { "<leader>bs", desc = "Scratch Buffer" },
      
      -- Code actions
      { "<leader>ca", desc = "Code Action" },
      { "<leader>cd", desc = "Line Diagnostics" },
      { "<leader>cf", desc = "Format Document" },
      { "<leader>ch", desc = "Signature Help" },
      { "<leader>ci", desc = "Hover Information" },
      { "<leader>cl", desc = "Codelens Action" },
      { "<leader>cr", desc = "Rename" },
      { "<leader>cs", desc = "Document Symbols" },
      { "<leader>cw", desc = "Workspace Symbols" },
      
      -- File/Find operations
      { "<leader>fb", desc = "Switch Buffer" },
      { "<leader>fc", desc = "Find Config File" },
      { "<leader>ff", desc = "Find Files (Root Dir)" },
      { "<leader>fF", desc = "Find Files (cwd)" },
      { "<leader>fg", desc = "Find Files (git-files)" },
      { "<leader>fn", desc = "New File" },
      { "<leader>fr", desc = "Recent Files" },
      { "<leader>fR", desc = "Recent Files (cwd)" },
      
      -- Git operations
      { "<leader>gb", desc = "Blame" },
      { "<leader>gc", desc = "Commits" },
      { "<leader>gd", desc = "Diff" },
      { "<leader>gg", desc = "Lazygit" },
      { "<leader>gl", desc = "Log" },
      { "<leader>gr", desc = "Reset Buffer" },
      { "<leader>gR", desc = "Reset Buffer (Hard)" },
      { "<leader>gs", desc = "Status" },
      
      -- Git hunks
      { "<leader>ghn", desc = "Next Hunk" },
      { "<leader>ghp", desc = "Preview Hunk" },
      { "<leader>ghP", desc = "Prev Hunk" },
      { "<leader>ghr", desc = "Reset Hunk" },
      { "<leader>ghs", desc = "Stage Hunk" },
      { "<leader>ghu", desc = "Undo Stage Hunk" },
      
      -- Search operations
      { "<leader>sb", desc = "Buffer" },
      { "<leader>sc", desc = "Command History" },
      { "<leader>sC", desc = "Commands" },
      { "<leader>sd", desc = "Document diagnostics" },
      { "<leader>sD", desc = "Workspace diagnostics" },
      { "<leader>sf", desc = "Files" },
      { "<leader>sg", desc = "Grep" },
      { "<leader>sG", desc = "Grep (cwd)" },
      { "<leader>sh", desc = "Help Pages" },
      { "<leader>sH", desc = "Highlight Groups" },
      { "<leader>sj", desc = "Jumplist" },
      { "<leader>sk", desc = "Keymaps" },
      { "<leader>sl", desc = "Location List" },
      { "<leader>sm", desc = "Jump to Mark" },
      { "<leader>sM", desc = "Man Pages" },
      { "<leader>so", desc = "Options" },
      { "<leader>sq", desc = "Quickfix List" },
      { "<leader>sr", desc = "Resume" },
      { "<leader>sR", desc = "Registers" },
      { "<leader>ss", desc = "Goto Symbol" },
      { "<leader>sS", desc = "Goto Symbol (Workspace)" },
      { "<leader>st", desc = "Todo" },
      { "<leader>sT", desc = "Todo/Fix/Fixme" },
      { "<leader>sw", desc = "Word (Root Dir)" },
      { "<leader>sW", desc = "Word (cwd)" },
      { "<leader>sa", desc = "Auto Commands" },
      { "<leader>s\"", desc = "Registers" },
      
      -- Terminal/Toggle operations
      { "<leader>tc", desc = "Toggle Conceal Level" },
      { "<leader>tf", desc = "Float Terminal" },
      { "<leader>th", desc = "Toggle Inlay Hints" },
      { "<leader>tl", desc = "Toggle Line Numbers" },
      { "<leader>tr", desc = "Toggle Relative Numbers" },
      { "<leader>ts", desc = "Toggle Spelling" },
      { "<leader>tt", desc = "Terminal (Root Dir)" },
      { "<leader>tT", desc = "Terminal (cwd)" },
      { "<leader>tw", desc = "Toggle Wrap" },
      
      -- UI/Toggle operations
      { "<leader>ub", desc = "Toggle Background" },
      { "<leader>uc", desc = "Colorscheme with Preview" },
      { "<leader>uC", desc = "Toggle Conceal" },
      { "<leader>ud", desc = "Toggle Diagnostics" },
      { "<leader>uf", desc = "Toggle Auto Format" },
      { "<leader>uh", desc = "Toggle Inlay Hints" },
      { "<leader>ui", desc = "Inspect Pos" },
      { "<leader>ul", desc = "Toggle Line Numbers" },
      { "<leader>uL", desc = "Toggle Relative Line Numbers" },
      { "<leader>un", desc = "Toggle Notifications" },
      { "<leader>ur", desc = "Toggle Relative Numbers" },
      { "<leader>us", desc = "Toggle Spelling" },
      { "<leader>ut", desc = "Toggle Treesitter Highlight" },
      { "<leader>uT", desc = "Toggle Treesitter Context" },
      { "<leader>uw", desc = "Toggle Wrap" },
      
      -- Window operations
      { "<leader>wd", desc = "Delete Window" },
      { "<leader>wh", desc = "Go to Left Window" },
      { "<leader>wj", desc = "Go to Lower Window" },
      { "<leader>wk", desc = "Go to Upper Window" },
      { "<leader>wl", desc = "Go to Right Window" },
      { "<leader>ws", desc = "Split Window Below" },
      { "<leader>wv", desc = "Split Window Right" },
      { "<leader>ww", desc = "Other Window" },
      { "<leader>w=", desc = "Balance Windows" },
      { "<leader>w_", desc = "Max Height" },
      { "<leader>w|", desc = "Max Width" },
      
      -- Diagnostics/Quickfix
      { "<leader>xd", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xD", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xl", desc = "Location List (Trouble)" },
      { "<leader>xq", desc = "Quickfix List (Trouble)" },
      { "<leader>xQ", desc = "Quickfix List" },
      { "<leader>xt", desc = "Todo (Trouble)" },
      { "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>xx", desc = "Trouble" },
      
      -- Open operations
      { "<leader>of", desc = "Open in File Manager" },
      { "<leader>ot", desc = "Open Terminal" },
      { "<leader>ou", desc = "Open URL under cursor" },
      { "<leader>ox", desc = "Open with Default App" },
      
      -- Run/Execute operations
      { "<leader>rm", desc = "Run make" },
      { "<leader>rr", desc = "Run current file" },
      { "<leader>rt", desc = "Run tests" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Custom highlights with Shades of Purple theme
    local colors = require("util.colors")
    
    vim.api.nvim_set_hl(0, "WhichKey", { fg = colors.colors.color4 })
    vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = colors.colors.color6 })
    vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = colors.colors.color2 })
    vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = colors.ui.border })
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = colors.ui.bg_secondary })
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = colors.ui.border, bg = colors.ui.bg_secondary })
    vim.api.nvim_set_hl(0, "WhichKeyValue", { fg = colors.colors.color5 })
    
    -- Language-specific mappings using wk.add for filetype-specific keybinds
    
    -- Python specific mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        wk.add({
          { "<leader>rp", "<cmd>!python %<cr>", desc = "Run Python file", buffer = true },
          { "<leader>rd", function() vim.cmd("!python -m pdb " .. vim.fn.expand("%")) end, desc = "Debug Python file", buffer = true },
        })
      end,
    })
    
    -- Shell script specific mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "sh", "bash", "zsh" },
      callback = function()
        wk.add({
          { "<leader>rs", "<cmd>!chmod +x % && ./%<cr>", desc = "Run shell script", buffer = true },
        })
      end,
    })
    
    -- Markdown specific mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        wk.add({
          { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Preview", buffer = true },
          { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview", buffer = true },
          { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Preview", buffer = true },
        })
      end,
    })
    
    -- SQL specific mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function()
        wk.add({
          { "<leader>rc", desc = "Connect to database", buffer = true },
          { "<leader>re", desc = "Execute SQL query", buffer = true },
        })
      end,
    })
    
    -- JSON/YAML specific mappings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "json", "yaml", "yml" },
      callback = function()
        wk.add({
          { "<leader>cv", desc = "Validate JSON/YAML", buffer = true },
        })
      end,
    })
  end,
}
