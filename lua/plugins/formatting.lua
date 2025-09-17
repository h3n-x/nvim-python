-- ========================================================================================
-- Formatting and Linting with none-ls (null-ls successor)
-- Languages: Python, Markdown, CSS, SQL, Bash, JSON, TOML, YAML
-- ========================================================================================

return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      local h = require("null-ls.helpers")
      local methods = require("null-ls.methods")
      
      local FORMATTING = methods.internal.FORMATTING
      local DIAGNOSTICS = methods.internal.DIAGNOSTICS
      
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          -- ========================================================================================
          -- Python
          -- ========================================================================================
          
          -- Black - Python formatter
          nls.builtins.formatting.black.with({
            extra_args = { "--fast", "--line-length", "88" },
            condition = function(utils)
              return utils.root_has_file({ "pyproject.toml", ".black", "setup.cfg" })
                or utils.root_has_file({ "requirements.txt", ".python-version" })
            end,
          }),
          
          -- isort - Python import sorter
          nls.builtins.formatting.isort.with({
            extra_args = { "--profile", "black" },
            condition = function(utils)
              return utils.root_has_file({ "pyproject.toml", ".isort.cfg", "setup.cfg" })
                or utils.root_has_file({ "requirements.txt", ".python-version" })
            end,
          }),
          
          -- MyPy - Python type checker
          nls.builtins.diagnostics.mypy.with({
            extra_args = function()
              local virtual_env = vim.env.VIRTUAL_ENV or vim.env.CONDA_DEFAULT_ENV
              if virtual_env then
                return { "--python-executable", virtual_env .. "/bin/python" }
              end
              return {}
            end,
            condition = function(utils)
              return utils.root_has_file({ "mypy.ini", ".mypy.ini", "pyproject.toml", "setup.cfg" })
            end,
          }),
          
          -- ========================================================================================
          -- Shell/Bash
          -- ========================================================================================
          
          -- shfmt - Shell formatter
          nls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "2", "-ci" }, -- 2 spaces indent, switch cases indent
          }),
          
          -- ========================================================================================
          -- Web/JSON/YAML
          -- ========================================================================================
          
          -- Prettier - Web formatter (JSON, YAML, CSS, HTML, etc.)
          nls.builtins.formatting.prettier.with({
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            filetypes = { 
              "javascript", "javascriptreact", "typescript", "typescriptreact",
              "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown",
              "markdown.mdx", "graphql", "handlebars"
            },
            condition = function(utils)
              return utils.root_has_file({
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettierrc.cjs",
                ".prettierrc.toml",
                "prettier.config.js",
                "prettier.config.cjs",
                "package.json",
              })
            end,
          }),
          
          -- ========================================================================================
          -- SQL
          -- ========================================================================================
          
          -- SQLFluff - SQL formatter and linter
          nls.builtins.formatting.sqlfluff.with({
            extra_args = { "--dialect", "postgres" }, -- Change to mysql, sqlite as needed
            condition = function(utils)
              return utils.root_has_file({ ".sqlfluff", "setup.cfg", "tox.ini", "pyproject.toml" })
            end,
          }),
          
          nls.builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "postgres" },
            condition = function(utils)
              return utils.root_has_file({ ".sqlfluff", "setup.cfg", "tox.ini", "pyproject.toml" })
            end,
          }),
          
          -- ========================================================================================
          -- Markdown
          -- ========================================================================================
          
          -- markdownlint - Markdown linter
          nls.builtins.diagnostics.markdownlint.with({
            condition = function(utils)
              return utils.root_has_file({
                ".markdownlint.json",
                ".markdownlint.jsonc",
                ".markdownlint.js",
                ".markdownlint.yaml",
                ".markdownlint.yml",
                ".markdownlintrc",
              })
            end,
          }),
          
          -- ========================================================================================
          -- Lua (for Neovim config)
          -- ========================================================================================
          
          -- stylua - Lua formatter
          nls.builtins.formatting.stylua.with({
            condition = function(utils)
              return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
            end,
          }),
          
          -- ========================================================================================
          -- General Purpose
          -- ========================================================================================
          
          -- Code actions
          nls.builtins.code_actions.gitsigns,
        },
        
        -- Configure diagnostics format
        diagnostics_format = "#{m} [#{c}]",
        
        -- Debounce text changes
        debounce = 1000,
        save_after_format = false,
        
        -- Configure sources on attach
        on_attach = function(client, bufnr)
          -- Format on save
          if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(format_client)
                    return format_client.name == "null-ls"
                  end,
                  bufnr = bufnr,
                  async = false,
                })
              end,
            })
          end
          
          -- Set up keymaps
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end
          
          if client:supports_method("textDocument/formatting") then
            map("<leader>cf", function()
              vim.lsp.buf.format({
                filter = function(format_client)
                  return format_client.name == "null-ls"
                end,
                async = true,
              })
            end, "Format Document")
          end
          
          if client:supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("v", "<leader>cf", function()
              vim.lsp.buf.format({
                filter = function(format_client)
                  return format_client.name == "null-ls"
                end,
                async = true,
              })
            end, { buffer = bufnr, desc = "Format Range" })
          end
        end,
      }
    end,
  },
  
  -- Mason integration for none-ls with modern API
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = function()
      return {
        ensure_installed = {
          -- Python
          "black",     -- Python formatter
          "isort",     -- Python import sorter 
          "mypy",      -- Type checker
          
          -- Shell
          "shfmt",
          
          -- Web/JSON/YAML
          "prettier",
          
          -- SQL
          "sqlfluff",
          
          -- Markdown
          "markdownlint",
          
          -- Lua
          "stylua",
        },
        automatic_installation = false,
        handlers = {
          -- Default handler
          function() end,
          
          -- Custom handlers for specific tools
          black = function()
            return require("null-ls").builtins.formatting.black.with({
              extra_args = { "--fast" },
            })
          end,
          
          prettier = function()
            return require("null-ls").builtins.formatting.prettier.with({
              filetypes = { "javascript", "typescript", "css", "scss", "html", "json", "yaml", "markdown" },
            })
          end,
          
          stylua = function()
            return require("null-ls").builtins.formatting.stylua
          end,
        },
      }
    end,
    config = function(_, opts)
      -- Use pcall to safely setup mason-null-ls
      local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
      if status_ok then
        mason_null_ls.setup(opts)
      end
    end,
  },
}
