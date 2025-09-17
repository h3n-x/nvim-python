-- ========================================================================================
-- Nvim-tree Configuration - File Explorer
-- Custom Shades of Purple theme with enhanced functionality
-- ========================================================================================

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer NvimTree (Root Dir)" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Explorer NvimTree (Current File)" },
  },
  opts = function()
    local colors = require("util.colors")
    
    return {
      auto_reload_on_write = true,
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = false,
      hijack_unnamed_buffer_when_opening = false,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = true,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom mappings
        vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
        vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
        vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
      end,
      select_prompts = false,
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 35,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 50,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "󰈚",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", "setup.py" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
      system_open = {
        cmd = "xdg-open", -- For Linux/Hyprland
        args = {},
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "⚑",
          info = "»",
          warning = "▲",
          error = "✘",
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { "node_modules", "\\.cache", "__pycache__", ".git" },
        exclude = { ".gitignore", ".env" },
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "rounded",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash", -- Use gio for trash on Linux
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
    }
  end,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    
    -- Custom highlights for Shades of Purple theme
    local colors = require("util.colors")
    
    local nvim_tree_highlights = {
      NvimTreeNormal = { bg = colors.ui.bg_sidebar, fg = colors.ui.fg_secondary },
      NvimTreeNormalNC = { bg = colors.ui.bg_sidebar, fg = colors.ui.fg_secondary },
      NvimTreeRootFolder = { fg = colors.colors.color4, bold = true },
      NvimTreeGitDirty = { fg = colors.ui.git_change },
      NvimTreeGitNew = { fg = colors.ui.git_add },
      NvimTreeGitDeleted = { fg = colors.ui.git_delete },
      NvimTreeGitStaged = { fg = colors.ui.git_add },
      NvimTreeGitMerge = { fg = colors.colors.color5 },
      NvimTreeGitRenamed = { fg = colors.colors.color3 },
      NvimTreeGitIgnored = { fg = colors.ui.fg_inactive },
      
      NvimTreeOpenedFile = { fg = colors.colors.color4, bold = true },
      NvimTreeModifiedFile = { fg = colors.colors.color3 },
      
      NvimTreeFolderName = { fg = colors.colors.color4 },
      NvimTreeOpenedFolderName = { fg = colors.colors.color12, bold = true },
      NvimTreeEmptyFolderName = { fg = colors.ui.fg_tertiary },
      NvimTreeFolderIcon = { fg = colors.colors.color4 },
      
      NvimTreeFileIcon = { fg = colors.ui.fg_secondary },
      NvimTreeExecFile = { fg = colors.colors.color2, bold = true },
      NvimTreeSymlink = { fg = colors.colors.color6 },
      NvimTreeSymlinkFolderName = { fg = colors.colors.color6 },
      
      NvimTreeIndentMarker = { fg = colors.ui.border },
      NvimTreeLiveFilterPrefix = { fg = colors.colors.color3, bold = true },
      NvimTreeLiveFilterValue = { fg = colors.colors.color3, bold = true },
      
      NvimTreeWindowPicker = { fg = colors.colors.background, bg = colors.colors.color3, bold = true },
      
      NvimTreeCursorLine = { bg = colors.ui.selection },
      NvimTreeCursorColumn = { bg = colors.ui.selection },
      
      -- Diagnostic highlights
      NvimTreeLspDiagnosticsError = { fg = colors.ui.error },
      NvimTreeLspDiagnosticsWarning = { fg = colors.ui.warning },
      NvimTreeLspDiagnosticsInformation = { fg = colors.ui.info },
      NvimTreeLspDiagnosticsHint = { fg = colors.ui.hint },
      
      -- Bookmarks
      NvimTreeBookmark = { fg = colors.colors.color5 },
      
      -- Special files
      NvimTreeSpecialFile = { fg = colors.colors.color3, underline = true },
      
      -- Git folder highlights
      NvimTreeGitFolderDirty = { fg = colors.ui.git_change },
      NvimTreeGitFolderStaged = { fg = colors.ui.git_add },
      NvimTreeGitFolderIgnored = { fg = colors.ui.fg_inactive },
    }
    
    for group, opts in pairs(nvim_tree_highlights) do
      vim.api.nvim_set_hl(0, group, opts)
    end
    
    -- Auto-close nvim-tree when it's the last window
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
      pattern = "NvimTree_*",
      callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
          vim.cmd("confirm quit")
        end
      end
    })
    
    -- Auto-open nvim-tree when starting Neovim with a directory
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if directory then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
}
