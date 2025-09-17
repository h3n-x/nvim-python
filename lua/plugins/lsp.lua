-- ========================================================================================
-- LSP Configuration with Mason
-- Languages: Python, Markdown, CSS, SQL, Bash, JSON, TOML, YAML
-- ========================================================================================

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- Python
        "pyright",                -- Python LSP
        "ruff-lsp",               -- Python linter/formatter LSP
        "black",                  -- Python formatter
        "isort",                  -- Python import sorter
        "mypy",                   -- Python type checker
        
        -- Bash/Shell
        "bash-language-server",   -- Bash LSP
        "shellcheck",             -- Shell script linter
        "shfmt",                  -- Shell formatter
        
        -- Web/JSON/YAML/TOML
        "css-lsp",                -- CSS LSP
        "html-lsp",               -- HTML LSP
        "json-lsp",               -- JSON LSP
        "yaml-language-server",   -- YAML LSP
        "taplo",                  -- TOML LSP and formatter
        "prettier",               -- Web formatter
        "eslint_d",               -- Fast ESLint
        
        -- SQL
        "sqlls",                  -- SQL LSP
        "sqlfluff",               -- SQL linter and formatter
        
        -- Markdown
        "marksman",               -- Markdown LSP
        "markdownlint",           -- Markdown linter
        
        -- General
        "lua-language-server",    -- Lua LSP (for Neovim config)
        "stylua",                 -- Lua formatter
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        },
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
      max_concurrent_installers = 10,
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",     -- Updated from ruff_lsp
        "bashls",
        "cssls",
        "html",
        "jsonls",
        "yamlls",
        "taplo",
        "sqlls",
        "marksman",
        "lua_ls",
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function()
      return {
        -- LSP Server settings
        servers = {
          -- Python
          pyright = {
            settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  autoImportCompletions = true,
                  diagnosticMode = "workspace",
                  stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
                },
              },
            },
          },
          
          ruff = {
            init_options = {
              settings = {
                args = {
                  "--config=pyproject.toml",
                },
              },
            },
          },
          
          -- Bash
          bashls = {
            filetypes = { "sh", "bash", "zsh" },
            settings = {
              bashIde = {
                globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
              },
            },
          },
          
          -- CSS
          cssls = {
            settings = {
              css = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
                },
              },
              scss = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
                },
              },
              less = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
                },
              },
            },
          },
          
          -- HTML
          html = {
            settings = {
              html = {
                format = {
                  enable = true,
                },
                hover = {
                  documentation = true,
                  references = true,
                },
              },
            },
          },
          
          -- JSON
          jsonls = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          },
          
          -- YAML
          yamlls = {
            settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                  ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
                  ["https://json.schemastore.org/ansible-stable-2.9.json"] = "/tasks/**/*.{yml,yaml}",
                  ["https://json.schemastore.org/prettierrc.json"] = "/.prettierrc.{yml,yaml}",
                  ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
                  ["https://json.schemastore.org/ansible-playbook.json"] = "/*play*.{yml,yaml}",
                  ["https://json.schemastore.org/chart.json"] = "/Chart.{yml,yaml}",
                  ["https://json.schemastore.org/dependabot-v2.json"] = "/.github/dependabot.{yml,yaml}",
                  ["https://json.schemastore.org/gitlab-ci.json"] = "/.gitlab-ci.{yml,yaml}",
                  ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose*.{yml,yaml}",
                },
                validate = true,
                completion = true,
                hover = true,
              },
            },
          },
          
          -- TOML
          taplo = {
            settings = {
              taplo = {
                configFile = {
                  enabled = true,
                },
              },
            },
          },
          
          -- SQL
          sqlls = {
            settings = {
              sql = {
                database = "postgresql", -- or "mysql", "sqlite"
              },
            },
          },
          
          -- Markdown
          marksman = {
            settings = {
              marksman = {
                completion = {
                  wiki = {
                    enabled = true,
                  },
                },
              },
            },
          },
          
          -- Lua (for Neovim config)
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        
        -- Global LSP settings
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "✘",
              [vim.diagnostic.severity.WARN] = "▲",
              [vim.diagnostic.severity.HINT] = "⚑",
              [vim.diagnostic.severity.INFO] = "»",
            },
          },
        },
        
        -- Inlay hints
        inlay_hints = {
          enabled = true,
          exclude = { "vue" },
        },
        
        -- Codelens
        codelens = {
          enabled = false,
        },
        
        -- Document formatting
        document_highlight = {
          enabled = true,
        },
        
        -- Capabilities
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      -- Setup diagnostics
      vim.diagnostic.config(opts.diagnostics)
      
      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities(),
        opts.capabilities or {}
      )
      
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, opts.servers[server] or {})
        
        if server == "ruff" then
          server_opts.on_attach = function(client, bufnr)
            -- Disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
          end
        end
        
        lspconfig[server].setup(server_opts)
      end
      
      -- Get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = mlsp.get_available_servers()
      end
      
      local ensure_installed = {}
      for server, server_opts in pairs(opts.servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end
      
      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            {}
          ),
          handlers = { setup },
        })
      end
    end,
  },

  -- Schema store for JSON/YAML schemas
  {
    "b0o/schemastore.nvim",
    lazy = true,
    version = false,
  },
}
