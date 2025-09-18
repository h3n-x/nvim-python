-- ========================================================================================
-- Formatting with conform.nvim
-- Languages: Python, Markdown, CSS, SQL, Bash, JSON, TOML, YAML, Lua
-- ========================================================================================

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Formatear Archivo",
      },
    },
    opts = {
      -- Configura los formateadores para cada tipo de archivo
      formatters_by_ft = {
        python = { "black", "isort" },
        lua = { "stylua" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        toml = { "taplo" },
        sql = { "sqlfluff" },
      },

      -- Habilita el formateo al guardar
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true, -- Usa el formateador del LSP si conform no tiene uno configurado
      },

      -- Configuración para `sqlfluff`
      formatters = {
        sqlfluff = {
          args = { "--dialect", "postgres" }, -- Cambia a mysql, sqlite, etc. según necesites
        },
      },
    },
    init = function()
      -- Permite que `conform` se use como fuente para `null-ls` si todavía está presente
      -- o para otros plugins que se integren con el formateo.
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
