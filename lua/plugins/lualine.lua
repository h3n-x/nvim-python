-- ========================================================================================
-- Lualine Configuration - Status Line
-- Custom Shades of Purple theme with comprehensive information display
-- ========================================================================================

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local colors = require("util.colors")
    
    -- Custom Shades of Purple theme for lualine
    local theme = {
      normal = {
        a = { bg = colors.colors.color4, fg = colors.colors.background, gui = "bold" },
        b = { bg = colors.ui.bg_secondary, fg = colors.colors.color4 },
        c = { bg = colors.ui.bg_statusline, fg = colors.ui.fg_secondary },
      },
      insert = {
        a = { bg = colors.colors.color2, fg = colors.colors.background, gui = "bold" },
        b = { bg = colors.ui.bg_secondary, fg = colors.colors.color2 },
      },
      visual = {
        a = { bg = colors.colors.color5, fg = colors.colors.background, gui = "bold" },
        b = { bg = colors.ui.bg_secondary, fg = colors.colors.color5 },
      },
      replace = {
        a = { bg = colors.colors.color1, fg = colors.colors.background, gui = "bold" },
        b = { bg = colors.ui.bg_secondary, fg = colors.colors.color1 },
      },
      command = {
        a = { bg = colors.colors.color3, fg = colors.colors.background, gui = "bold" },
        b = { bg = colors.ui.bg_secondary, fg = colors.colors.color3 },
      },
      inactive = {
        a = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_inactive },
        b = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_inactive },
        c = { bg = colors.ui.bg_secondary, fg = colors.ui.fg_inactive },
      },
    }

    local icons = {
      diagnostics = {
        Error = "✘ ",
        Warn = "▲ ",
        Hint = "⚑ ",
        Info = "» ",
      },
      git = {
        added = " ",
        modified = " ",
        removed = " ",
      },
      kinds = {
        Array = " ",
        Boolean = "󰨙 ",
        Class = " ",
        Constant = "󰏿 ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Function = "󰊕 ",
        Interface = " ",
        Key = " ",
        Method = "󰊕 ",
        Module = " ",
        Namespace = "󰦮 ",
        Null = " ",
        Number = "󰎠 ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        String = " ",
        Struct = "󰆼 ",
        TypeParameter = " ",
        Variable = "󰀫 ",
      },
    }

    local function fg(name)
      return function()
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    return {
      options = {
        theme = theme,
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              local mode_map = {
                ["NORMAL"] = "N",
                ["INSERT"] = "I",
                ["VISUAL"] = "V",
                ["V-LINE"] = "VL",
                ["V-BLOCK"] = "VB",
                ["COMMAND"] = "C",
                ["REPLACE"] = "R",
                ["SELECT"] = "S",
                ["TERMINAL"] = "T",
              }
              return mode_map[str] or str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.colors.color4 },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = icons.diagnostics,
            colored = true,
            diagnostics_color = {
              error = { fg = colors.ui.error },
              warn = { fg = colors.ui.warning },
              info = { fg = colors.ui.info },
              hint = { fg = colors.ui.hint },
            },
          },
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 },
          },
          {
            "filename",
            path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = " ",
            },
            color = { fg = colors.ui.fg_primary },
          },
        },
        lualine_x = {
          -- Python virtual environment
          {
            function()
              local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV
              if venv then
                local venv_name = vim.fn.fnamemodify(venv, ":t")
                return "🐍 " .. venv_name
              end
              return ""
            end,
            cond = function()
              return vim.bo.filetype == "python"
            end,
            color = { fg = colors.colors.color2 },
          },
          -- LSP status
          {
            function()
              local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
              if #buf_clients == 0 then
                return "LSP Inactive"
              end

              local buf_ft = vim.bo.filetype
              local buf_client_names = {}
              local null_ls_sources = {}

              -- Add LSP clients
              for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" and client.name ~= "copilot" then
                  table.insert(buf_client_names, client.name)
                end
              end

              -- Add null-ls sources
              local null_ls_ok, null_ls = pcall(require, "null-ls")
              if null_ls_ok then
                local sources = null_ls.get_source({
                  filetype = buf_ft,
                })
                for _, source in pairs(sources) do
                  table.insert(null_ls_sources, source.name)
                end
              end

              local language_servers = table.concat(buf_client_names, ", ")
              local formatters = table.concat(null_ls_sources, ", ")
              
              if language_servers ~= "" and formatters ~= "" then
                return language_servers .. " | " .. formatters
              elseif language_servers ~= "" then
                return language_servers
              elseif formatters ~= "" then
                return formatters
              else
                return "LSP Inactive"
              end
            end,
            icon = "󰒋",
            color = { fg = colors.colors.color6 },
          },
          -- Git diff
          {
            "diff",
            symbols = icons.git,
            colored = true,
            diff_color = {
              added = { fg = colors.ui.git_add },
              modified = { fg = colors.ui.git_change },
              removed = { fg = colors.ui.git_delete },
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          {
            "progress",
            separator = " ",
            padding = { left = 1, right = 0 },
          },
          {
            "location",
            padding = { left = 0, right = 1 },
          },
        },
        lualine_z = {
          {
            function()
              local current_line = vim.fn.line(".")
              local total_lines = vim.fn.line("$")
              local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
              local line_ratio = current_line / total_lines
              local index = math.ceil(line_ratio * #chars)
              return chars[index]
            end,
            color = { fg = colors.colors.color4, bg = colors.ui.bg_secondary },
            padding = 1,
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "nvim-tree", "lazy", "trouble", "mason", "man" },
    }
  end,
  config = function(_, opts)
    require("lualine").setup(opts)
    
    -- Restore statusline
    vim.o.laststatus = vim.g.lualine_laststatus
    
    -- Custom highlight corrections
    local colors = require("util.colors")
    
    -- Ensure consistent colors
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = colors.colors.color4, fg = colors.colors.background, bold = true })
        vim.api.nvim_set_hl(0, "lualine_a_insert", { bg = colors.colors.color2, fg = colors.colors.background, bold = true })
        vim.api.nvim_set_hl(0, "lualine_a_visual", { bg = colors.colors.color5, fg = colors.colors.background, bold = true })
        vim.api.nvim_set_hl(0, "lualine_a_replace", { bg = colors.colors.color1, fg = colors.colors.background, bold = true })
        vim.api.nvim_set_hl(0, "lualine_a_command", { bg = colors.colors.color3, fg = colors.colors.background, bold = true })
      end,
    })
  end,
}
