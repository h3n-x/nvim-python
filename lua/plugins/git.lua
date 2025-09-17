-- ========================================================================================
-- Git Integration with Gitsigns
-- Custom Shades of Purple theme with enhanced git functionality
-- ========================================================================================

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end
      
      -- Navigation
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      
      -- Actions
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      
      -- Toggle
      map("n", "<leader>gtb", gs.toggle_current_line_blame, "Toggle Git Blame Line")
      map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Git Deleted")
      
      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    watch_gitdir = {
      follow_files = true,
    },
    diff_opts = {
      algorithm = "patience",
      internal = false, -- Use external diff
      indent_heuristic = true,
      vertical = false,
    },
    word_diff = false,
    trouble = true,
    yadm = {
      enable = false,
    },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
    
    -- Custom highlights for Shades of Purple theme
    local colors = require("util.colors")
    
    local gitsigns_highlights = {
      -- Sign column
      GitSignsAdd = { fg = colors.ui.git_add },
      GitSignsChange = { fg = colors.ui.git_change },
      GitSignsDelete = { fg = colors.ui.git_delete },
      GitSignsTopdelete = { fg = colors.ui.git_delete },
      GitSignsChangedelete = { fg = colors.ui.git_change },
      GitSignsUntracked = { fg = colors.colors.color5 },
      
      -- Staged signs
      GitSignsAddPreview = { fg = colors.ui.git_add },
      GitSignsDeletePreview = { fg = colors.ui.git_delete },
      
      -- Line highlighting
      GitSignsAddLn = { bg = colors.darken(colors.ui.git_add, 90) },
      GitSignsChangeLn = { bg = colors.darken(colors.ui.git_change, 90) },
      GitSignsDeleteLn = { bg = colors.darken(colors.ui.git_delete, 90) },
      GitSignsTopDeleteLn = { bg = colors.darken(colors.ui.git_delete, 90) },
      GitSignsChangeDeleteLn = { bg = colors.darken(colors.ui.git_change, 90) },
      GitSignsUntrackedLn = { bg = colors.darken(colors.colors.color5, 90) },
      
      -- Number column highlighting
      GitSignsAddNr = { fg = colors.ui.git_add },
      GitSignsChangeNr = { fg = colors.ui.git_change },
      GitSignsDeleteNr = { fg = colors.ui.git_delete },
      GitSignsTopDeleteNr = { fg = colors.ui.git_delete },
      GitSignsChangeDeleteNr = { fg = colors.ui.git_change },
      GitSignsUntrackedNr = { fg = colors.colors.color5 },
      
      -- Current line blame
      GitSignsCurrentLineBlame = { fg = colors.ui.fg_inactive, italic = true },
      
      -- Word diff
      GitSignsAddInline = { bg = colors.darken(colors.ui.git_add, 75) },
      GitSignsChangeInline = { bg = colors.darken(colors.ui.git_change, 75) },
      GitSignsDeleteInline = { bg = colors.darken(colors.ui.git_delete, 75) },
      
      -- Staged highlights
      GitSignsAddLnInline = { bg = colors.darken(colors.ui.git_add, 80) },
      GitSignsChangeLnInline = { bg = colors.darken(colors.ui.git_change, 80) },
      GitSignsDeleteLnInline = { bg = colors.darken(colors.ui.git_delete, 80) },
      
      -- Additional highlights for better integration
      GitSignsAddCul = { bg = colors.blend(colors.ui.git_add, colors.ui.cursor_line, 0.2) },
      GitSignsChangeCul = { bg = colors.blend(colors.ui.git_change, colors.ui.cursor_line, 0.2) },
      GitSignsDeleteCul = { bg = colors.blend(colors.ui.git_delete, colors.ui.cursor_line, 0.2) },
    }
    
    for group, opts_hl in pairs(gitsigns_highlights) do
      vim.api.nvim_set_hl(0, group, opts_hl)
    end
    
    -- Additional autocommands for enhanced git integration
    local augroup = vim.api.nvim_create_augroup("GitSigns", { clear = true })
    
    -- Auto-refresh gitsigns when switching branches
    vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
      group = augroup,
      pattern = "*",
      callback = function()
        if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
          require("gitsigns").refresh()
        end
      end,
    })
    
    -- Show git blame on cursor hold
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = augroup,
      pattern = "*",
      callback = function()
        if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
          local gitsigns = require("gitsigns")
          if gitsigns.toggle_current_line_blame then
            -- Only show blame if not already showing
            local blame_enabled = vim.b.gitsigns_blame_line_dict ~= nil
            if not blame_enabled then
              vim.defer_fn(function()
                gitsigns.blame_line({ full = false })
              end, 1000)
            end
          end
        end
      end,
    })
    
    -- Clear git blame on cursor move
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = augroup,
      pattern = "*",
      callback = function()
        -- Clear any temporary blame display
        if vim.b.gitsigns_blame_line_dict then
          vim.b.gitsigns_blame_line_dict = nil
        end
      end,
    })
    
    -- Integrate with statusline and other plugins
    vim.api.nvim_create_autocmd({ "User" }, {
      group = augroup,
      pattern = "GitSignsUpdate",
      callback = function()
        -- Trigger statusline refresh when git status changes
        vim.cmd("redrawstatus")
      end,
    })
  end,
}
