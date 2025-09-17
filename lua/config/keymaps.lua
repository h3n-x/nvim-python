-- ========================================================================================
-- Key Mappings Configuration
-- Optimized for development workflow with Hyprland window management
-- ========================================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ========================================================================================
-- Leader Key Configuration
-- ========================================================================================
-- Leader is set in init.lua as " " (space)

-- ========================================================================================
-- General Mappings
-- ========================================================================================

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Better up/down for wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- ========================================================================================
-- Buffer Management
-- ========================================================================================

-- Move between buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Close buffers
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete Buffer (Force)" })

-- ========================================================================================
-- Tab Management
-- ========================================================================================

map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- ========================================================================================
-- Text Editing and Movement
-- ========================================================================================

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Better paste (don't replace clipboard with deleted text)
map("x", "p", [["_dP]], opts)

-- Delete to void register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Copy to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Replace current word
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace current word" })

-- ========================================================================================
-- File Operations
-- ========================================================================================

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit All (Force)" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- ========================================================================================
-- LSP and Diagnostics (these will be enhanced by LSP plugin)
-- ========================================================================================

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>cl", vim.diagnostic.setloclist, { desc = "Diagnostic Loclist" })

-- ========================================================================================
-- Formatting and Code Actions
-- ========================================================================================

-- Format document
map({ "n", "v" }, "<leader>cf", function()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ async = true, lsp_fallback = true })
  else
    vim.lsp.buf.format({ async = true })
  end
end, { desc = "Format Document" })

-- ========================================================================================
-- Terminal
-- ========================================================================================

-- Terminal mappings
map("n", "<leader>tt", function()
  vim.cmd("terminal")
end, { desc = "Terminal" })

map("n", "<leader>tT", function()
  vim.cmd("tabnew | terminal")
end, { desc = "Terminal (Tab)" })

-- Exit terminal mode
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Terminal window navigation
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })

-- ========================================================================================
-- Splits and Windows
-- ========================================================================================

map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- ========================================================================================
-- Search and Replace
-- ========================================================================================

-- Search for selected text in visual mode
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { desc = "Search selected text" })

-- Search and replace in visual selection
map("v", "<leader>sr", [[:s/\%V]], { desc = "Search & Replace in selection" })

-- Search and replace in entire file
map("n", "<leader>sr", [[:%s/]], { desc = "Search & Replace in file" })

-- ========================================================================================
-- Folding
-- ========================================================================================

map("n", "<leader>zo", "zO", { desc = "Open all folds under cursor" })
map("n", "<leader>zc", "zC", { desc = "Close all folds under cursor" })
map("n", "<leader>zr", "zR", { desc = "Open all folds" })
map("n", "<leader>zm", "zM", { desc = "Close all folds" })

-- ========================================================================================
-- Quickfix and Location List
-- ========================================================================================

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- ========================================================================================
-- Highlighting and Inspection
-- ========================================================================================

-- Inspect highlight groups under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- ========================================================================================
-- Toggle Options
-- ========================================================================================

local toggle_map = function(key, option, desc)
  map("n", key, function()
    if vim.opt[option]:get() then
      vim.opt[option] = false
      vim.notify(desc .. " disabled", vim.log.levels.INFO)
    else
      vim.opt[option] = true
      vim.notify(desc .. " enabled", vim.log.levels.INFO)
    end
  end, { desc = "Toggle " .. desc })
end

toggle_map("<leader>uw", "wrap", "Word Wrap")
toggle_map("<leader>ur", "relativenumber", "Relative Numbers")
toggle_map("<leader>ul", "list", "List Chars")
toggle_map("<leader>us", "spell", "Spell Check")

-- Toggle background
map("n", "<leader>ub", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.notify("Background: light", vim.log.levels.INFO)
  else
    vim.o.background = "dark"
    vim.notify("Background: dark", vim.log.levels.INFO)
  end
end, { desc = "Toggle Background" })

-- ========================================================================================
-- Utility Functions
-- ========================================================================================

-- Open current directory in file manager (for Hyprland)
map("n", "<leader>of", function()
  local cwd = vim.fn.getcwd()
  vim.fn.system("thunar " .. vim.fn.shellescape(cwd) .. " &")
end, { desc = "Open in File Manager" })

-- Open current file in default application
map("n", "<leader>ox", function()
  local file = vim.fn.expand("%:p")
  if file and file ~= "" then
    vim.fn.system("xdg-open " .. vim.fn.shellescape(file) .. " &")
  end
end, { desc = "Open with Default App" })

-- ========================================================================================
-- Language-specific mappings
-- ========================================================================================

-- Python specific keymaps (will be enhanced by python LSP)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    map("n", "<leader>rr", "<cmd>!python %<cr>", { desc = "Run Python file", buffer = true })
    -- Avante integration for Python
    map("n", "<leader>aP", function()
      if pcall(require, "avante.api") then
        require("avante.api").ask({
          question = "Review this Python code for best practices, performance, and potential issues. Suggest improvements.",
        })
      end
    end, { desc = "Avante Python review", buffer = true })
  end,
})

-- Bash specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    map("n", "<leader>rr", "<cmd>!chmod +x % && ./%<cr>", { desc = "Run script", buffer = true })
    -- Avante integration for shell scripts
    map("n", "<leader>aS", function()
      if pcall(require, "avante.api") then
        require("avante.api").ask({
          question = "Review this shell script for best practices, security issues, and potential improvements.",
        })
      end
    end, { desc = "Avante shell review", buffer = true })
  end,
})

-- Markdown specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview", buffer = true })
    -- Avante integration for Markdown
    map("n", "<leader>aM", function()
      if pcall(require, "avante.api") then
        require("avante.api").ask({
          question = "Improve this markdown document's structure, clarity, and formatting.",
        })
      end
    end, { desc = "Avante markdown improve", buffer = true })
  end,
})
