-- ========================================================================================
-- Autocommands Configuration
-- Automated behaviors for enhanced development workflow
-- ========================================================================================

local api = vim.api

-- ========================================================================================
-- Utility Functions
-- ========================================================================================

-- Create autocommand group
local function augroup(name)
  return api.nvim_create_augroup("shades_" .. name, { clear = true })
end

-- ========================================================================================
-- File Type Detection and Language-Specific Settings
-- ========================================================================================

-- Better file type detection
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("filetype_detection"),
  pattern = {
    "*.py.in", "*.pyi",
    "*.sql", "*.mysql", "*.pgsql",
    "*.md", "*.markdown", "*.mdown", "*.mkdn", "*.mkd", "*.mdwn", "*.mdtxt", "*.mdtext",
    "*.toml",
    "*.yml", "*.yaml",
    "*.css", "*.scss", "*.sass", "*.less",
    "*.sh", "*.bash", "*.zsh", "*.fish",
    "*.json", "*.jsonc", "*.json5",
  },
  callback = function(args)
    local file = args.file
    if vim.fn.match(file, "\\.py\\.in$") > -1 or vim.fn.match(file, "\\.pyi$") > -1 then
      vim.bo.filetype = "python"
    elseif vim.fn.match(file, "\\.\\(sql\\|mysql\\|pgsql\\)$") > -1 then
      vim.bo.filetype = "sql"
    elseif vim.fn.match(file, "\\.\\(md\\|markdown\\|mdown\\|mkdn\\|mkd\\|mdwn\\|mdtxt\\|mdtext\\)$") > -1 then
      vim.bo.filetype = "markdown"
    elseif vim.fn.match(file, "\\.toml$") > -1 then
      vim.bo.filetype = "toml"
    elseif vim.fn.match(file, "\\.\\(yml\\|yaml\\)$") > -1 then
      vim.bo.filetype = "yaml"
    elseif vim.fn.match(file, "\\.\\(css\\|scss\\|sass\\|less\\)$") > -1 then
      vim.bo.filetype = "css"
    elseif vim.fn.match(file, "\\.\\(sh\\|bash\\|zsh\\|fish\\)$") > -1 then
      vim.bo.filetype = "sh"
    elseif vim.fn.match(file, "\\.\\(json\\|jsonc\\|json5\\)$") > -1 then
      vim.bo.filetype = "json"
    end
  end,
})

-- ========================================================================================
-- Auto-format on Save
-- ========================================================================================

api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_format"),
  pattern = {
    "*.py", "*.pyi",
    "*.js", "*.ts", "*.jsx", "*.tsx",
    "*.json", "*.jsonc",
    "*.yaml", "*.yml",
    "*.toml",
    "*.css", "*.scss", "*.sass", "*.less",
    "*.sh", "*.bash", "*.zsh",
    "*.md", "*.markdown",
  },
  callback = function()
    -- Check if conform.nvim is available, otherwise use LSP formatting
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ async = false, lsp_fallback = true })
    else
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- ========================================================================================
-- Highlight Yanked Text
-- ========================================================================================

api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 300,
    })
  end,
})

-- ========================================================================================
-- Auto-resize Windows
-- ========================================================================================

api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ========================================================================================
-- Remember Last Position
-- ========================================================================================

api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = api.nvim_buf_get_mark(buf, '"')
    local lcount = api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ========================================================================================
-- Close Some Filetypes with 'q'
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns.blame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- ========================================================================================
-- Wrap and Check for Spell in Text Filetypes
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "*.txt", "*.md", "*.tex", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- ========================================================================================
-- Terminal Settings
-- ========================================================================================

api.nvim_create_autocmd("TermOpen", {
  group = augroup("terminal_settings"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
    
    -- Start in insert mode
    vim.cmd("startinsert")
  end,
})

-- Auto insert mode when entering terminal buffer
api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
  group = augroup("terminal_auto_insert"),
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- ========================================================================================
-- Python-specific Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("python_settings"),
  pattern = "python",
  callback = function()
    -- Set textwidth for Python files
    vim.opt_local.textwidth = 88
    -- vim.opt_local.colorcolumn = "89"  -- Disabled: removes vertical line
    
    -- Better indentation for Python
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    
    -- Python specific comment string
    vim.opt_local.commentstring = "# %s"
  end,
})

-- ========================================================================================
-- YAML/TOML Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("yaml_toml_settings"),
  pattern = { "yaml", "yml", "toml" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.indentkeys = vim.opt_local.indentkeys:append("!^F,o,O")
  end,
})

-- ========================================================================================
-- JSON Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("json_settings"),
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.conceallevel = 0
  end,
})

-- ========================================================================================
-- Markdown Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("markdown_settings"),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.spell = true
    vim.opt_local.conceallevel = 0
    vim.opt_local.textwidth = 80
    -- vim.opt_local.colorcolumn = "81"  -- Disabled: removes vertical line
  end,
})

-- ========================================================================================
-- CSS/SCSS Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("css_settings"),
  pattern = { "css", "scss", "sass", "less" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ========================================================================================
-- Shell Script Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("shell_settings"),
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ========================================================================================
-- SQL Settings
-- ========================================================================================

api.nvim_create_autocmd("FileType", {
  group = augroup("sql_settings"),
  pattern = "sql",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.commentstring = "-- %s"
  end,
})

-- ========================================================================================
-- Auto-create Directories
-- ========================================================================================

api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ========================================================================================
-- Big File Optimization
-- ========================================================================================

api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
  group = augroup("big_file"),
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand("<afile>"))
    if file_size > 1024 * 1024 then -- 1MB
      vim.opt_local.eventignore:append({
        "FileType",
        "Syntax",
        "BufEnter",
        "BufLeave",
        "BufWinEnter",
        "BufWinLeave",
        "InsertEnter",
        "InsertLeave",
      })
      vim.opt_local.undolevels = -1
      vim.opt_local.undoreload = 0
      vim.opt_local.swapfile = false
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.syntax = "off"
    end
  end,
})

-- ========================================================================================
-- Hyprland-specific Settings
-- ========================================================================================

-- Set transparency for floating windows in Hyprland
if vim.env.XDG_SESSION_DESKTOP == "Hyprland" or vim.env.HYPRLAND_INSTANCE_SIGNATURE then
  api.nvim_create_autocmd({ "WinEnter", "WinNew" }, {
    group = augroup("hyprland_transparency"),
    callback = function()
      local win_config = api.nvim_win_get_config(0)
      if win_config.relative ~= "" then
        vim.wo.winblend = 10
      end
    end,
  })
end

-- ========================================================================================
-- LSP Attach Settings
-- ========================================================================================

api.nvim_create_autocmd("LspAttach", {
  group = augroup("lsp_attach"),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- LSP keymaps
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("gy", require("telescope.builtin").lsp_type_definitions, "T[y]pe Definition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    -- Highlight symbol under cursor
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = api.nvim_create_augroup("shades-lsp-highlight", { clear = false })
      api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      api.nvim_create_autocmd("LspDetach", {
        group = api.nvim_create_augroup("shades-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          api.nvim_clear_autocmds({ group = "shades-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- Toggle inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})
