-- ========================================================================================
-- Treesitter Configuration - Syntax Highlighting and Text Objects
-- Optimized for Python, Markdown, CSS, SQL, Bash, JSON, TOML, YAML
-- ========================================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make
      -- available during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          -- When in diff mode, we want to use the default
          -- vim text objects c & C instead of the treesitter ones.
          local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
          local configs = require("nvim-treesitter.configs")
          for name, fn in pairs(move) do
            if name:find("goto") == 1 then
              move[name] = function(q, ...)
                if vim.wo.diff then
                  local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                  for key, query in pairs(config or {}) do
                    if q == query and key:find("[%]%[][cC]") then
                      vim.cmd("normal! " .. key)
                      return
                    end
                  end
                end
                return fn(q, ...)
              end
            end
          end
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          enable = true,
          max_lines = 2,        -- Reducido de 3 a 2
          min_window_height = 20, -- Solo muestra en ventanas grandes
          line_numbers = false,  -- Sin números de línea para menos distracción
          multiline_threshold = 2, -- Más restrictivo
          trim_scope = "outer",
          mode = "topline",     -- Cambiado de "cursor" a "topline"
          separator = "─",      -- Línea separadora sutil
          zindex = 20,
          on_attach = nil,
        },
        config = function(_, opts)
          require("treesitter-context").setup(opts)
          
          local colors = require("util.colors")
          -- Hacer el contexto más sutil con menor contraste
          vim.api.nvim_set_hl(0, "TreesitterContext", { 
            bg = colors.ui.bg, 
            fg = colors.ui.comments,
            italic = true 
          })
          -- Refuerzo: oculta por completo los números de línea del contexto de treesitter-context
          vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = colors.ui.bg, bg = colors.ui.bg, blend = 100, nocombine = true })
          vim.api.nvim_set_hl(0, "LineNr", { fg = colors.ui.bg, bg = colors.ui.bg, blend = 100, nocombine = true })
          vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { 
            fg = colors.ui.border,
            bg = colors.ui.bg 
          })
          
          -- Keymap para toggle del contexto
          vim.keymap.set('n', '<leader>tc', function()
            require("treesitter-context").toggle()
          end, { desc = "Toggle Treesitter Context" })
        end,
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "python", "yaml" }, -- Better handled by language-specific plugins
      },
      ensure_installed = {
        -- Target languages
        "python",
        "bash",
        "css",
        "scss",
        "sql",
        "markdown",
        "markdown_inline",
        "json",
        "json5",
        "jsonc", 
        "toml",
        "yaml",
        
        -- Web technologies (for comprehensive support)
        "html",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        
        -- Configuration and documentation
        "lua",
        "vim",
        "vimdoc",
        "query",
        "regex",
        
        -- Version control and markup
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "diff",
        
        -- Common formats
        "xml",
        "ini",
        "comment",
        
        -- Shell and system
        "dockerfile",
        "make",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ii"] = "@conditional.inner",
            ["ai"] = "@conditional.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["at"] = "@comment.outer",
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "V", -- linewise
          },
          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            ["]o"] = "@loop.*",
            ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[o"] = "@loop.*",
            ["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
            ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          goto_next = {
            ["]d"] = "@conditional.outer",
          },
          goto_previous = {
            ["[d"] = "@conditional.outer",
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
        lsp_interop = {
          enable = true,
          border = "rounded",
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = {
          unpack(opts.ensure_installed),
        }
      end
      require("nvim-treesitter.configs").setup(opts)
      
      -- Custom highlight groups for better syntax highlighting
      local colors = require("util.colors")
      
      -- Python-specific highlights
      vim.api.nvim_set_hl(0, "@keyword.function.python", { fg = colors.syntax.keyword, italic = true })
      vim.api.nvim_set_hl(0, "@keyword.return.python", { fg = colors.syntax.keyword, italic = true })
      vim.api.nvim_set_hl(0, "@keyword.exception.python", { fg = colors.syntax.exception, italic = true })
      vim.api.nvim_set_hl(0, "@constructor.python", { fg = colors.syntax.class })
      vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = colors.syntax.builtin })
      vim.api.nvim_set_hl(0, "@function.builtin.python", { fg = colors.syntax.builtin })
      vim.api.nvim_set_hl(0, "@constant.builtin.python", { fg = colors.syntax.builtin })
      
      -- Bash-specific highlights
      vim.api.nvim_set_hl(0, "@keyword.bash", { fg = colors.syntax.keyword })
      vim.api.nvim_set_hl(0, "@variable.bash", { fg = colors.syntax.variable })
      vim.api.nvim_set_hl(0, "@string.bash", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "@string.escape.bash", { fg = colors.syntax.string_escape })
      
      -- CSS-specific highlights
      vim.api.nvim_set_hl(0, "@property.css", { fg = colors.syntax.property })
      vim.api.nvim_set_hl(0, "@string.css", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "@number.css", { fg = colors.syntax.number })
      vim.api.nvim_set_hl(0, "@function.css", { fg = colors.syntax["function"] })
      
      -- JSON-specific highlights
      vim.api.nvim_set_hl(0, "@property.json", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "@string.json", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "@number.json", { fg = colors.syntax.number })
      vim.api.nvim_set_hl(0, "@boolean.json", { fg = colors.syntax.boolean })
      
      -- YAML-specific highlights
      vim.api.nvim_set_hl(0, "@property.yaml", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "@string.yaml", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "@number.yaml", { fg = colors.syntax.number })
      vim.api.nvim_set_hl(0, "@boolean.yaml", { fg = colors.syntax.boolean })
      
      -- TOML-specific highlights
      vim.api.nvim_set_hl(0, "@property.toml", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "@string.toml", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "@number.toml", { fg = colors.syntax.number })
      vim.api.nvim_set_hl(0, "@boolean.toml", { fg = colors.syntax.boolean })
      
      -- SQL-specific highlights
      vim.api.nvim_set_hl(0, "@keyword.sql", { fg = colors.syntax.keyword, bold = true })
      vim.api.nvim_set_hl(0, "@function.sql", { fg = colors.syntax["function"] })
      vim.api.nvim_set_hl(0, "@string.sql", { fg = colors.syntax.string })
      vim.api.nvim_set_hl(0, "@number.sql", { fg = colors.syntax.number })
      
      -- Markdown-specific highlights
      vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = colors.colors.color4, bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = colors.colors.color12, bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = colors.colors.color5, bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = colors.colors.color6, bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = colors.colors.color3, bold = true })
      vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = colors.colors.color2, bold = true })
      vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = colors.colors.color3, bold = true })
      vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = colors.colors.color5, italic = true })
      vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = colors.syntax.string, bg = colors.ui.bg_secondary })
      vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = colors.syntax.string, bg = colors.ui.bg_secondary })
      vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { fg = colors.colors.color6, underline = true })
      vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = colors.colors.color6, underline = true })
      vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "@markup.quote.markdown", { fg = colors.ui.fg_tertiary, italic = true })
    end,
  },

  -- Rainbow delimiters for better bracket visualization
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      local colors = require("util.colors")
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
      
      -- Set up rainbow delimiter colors with Shades of Purple theme
      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = colors.colors.color1 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = colors.colors.color3 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.ui.orange })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = colors.colors.color2 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.colors.color5 })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = colors.colors.color6 })
    end,
  },
}
