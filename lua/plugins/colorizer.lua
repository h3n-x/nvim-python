-- ========================================================================================
-- Color Preview Plugin
-- Shows color previews directly in CSS, SCSS, HTML and other files
-- ========================================================================================

return {
  -- nvim-colorizer - Color highlighter
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "css",
        "scss",
        "sass",
        "html",
        "javascript",
        "typescript",
        "jsx",
        "tsx",
        "vue",
        "svelte",
        "lua",
        "vim",
        "toml",
        "yaml",
        "json",
        "conf",
        "dosini",
      },
      user_default_options = {
        RGB = true,         -- #RGB hex codes
        RRGGBB = true,      -- #RRGGBB hex codes
        names = true,       -- "Name" codes like Blue or blue
        RRGGBBAA = true,    -- #RRGGBBAA hex codes
        AARRGGBB = false,   -- 0xAARRGGBB hex codes
        rgb_fn = true,      -- CSS rgb() and rgba() functions
        hsl_fn = true,      -- CSS hsl() and hsla() functions
        css = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false,     -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
      
      -- Custom highlights for better integration with Shades of Purple theme
      local colors = require("util.colors")
      
      -- Set up autocommands for better performance
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.css", "*.scss", "*.sass", "*.html", "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue" },
        callback = function()
          vim.cmd("ColorizerAttachToBuffer")
        end,
      })
      
      -- Keymaps for colorizer
      vim.keymap.set("n", "<leader>uc", "<cmd>ColorizerToggle<cr>", { desc = "Toggle Color Preview" })
      vim.keymap.set("n", "<leader>uC", "<cmd>ColorizerReloadAllBuffers<cr>", { desc = "Reload Color Preview" })
    end,
  },
  
  -- Alternative: nvim-highlight-colors (more modern)
  {
    "brenoprata10/nvim-highlight-colors",
    enabled = false, -- Disable by default, enable if you prefer this one
    event = "BufReadPre",
    opts = {
      render = "background", -- 'background', 'foreground', 'virtual'
      virtual_symbol = "■",
      virtual_symbol_prefix = "",
      virtual_symbol_suffix = " ",
      virtual_symbol_position = "inline", -- 'inline', 'eol', 'eow'
      enable_hex = true,
      enable_short_hex = true,
      enable_rgb = true,
      enable_hsl = true,
      enable_var_usage = true,
      enable_named_colors = true,
      enable_tailwind = false,
      -- Exclude filetypes
      exclude_filetypes = {},
      -- Exclude buftypes
      exclude_buftypes = {
        "text",
      }
    },
    config = function(_, opts)
      require("nvim-highlight-colors").setup(opts)
      
      -- Keymaps
      vim.keymap.set("n", "<leader>uc", "<cmd>HighlightColors Toggle<cr>", { desc = "Toggle Color Preview" })
    end,
  },
}
