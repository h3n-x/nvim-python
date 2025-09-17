-- Indent guides and scope highlighting for Neovim using Catppuccin Mocha colors
-- Requires: 'lukas-reineke/indent-blankline.nvim'

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Oculta la guía de indentación en el primer nivel (no mostrar columna extra a la izquierda)
    local ibl_ok, ibl = pcall(require, "ibl")
    if ibl_ok then
      -- Configuración avanzada de indent-blankline (ibl) con colores Catppuccin Mocha
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      local hooks = require("ibl.hooks")

      -- Define los grupos de highlight para los niveles de indentación (tipo rainbow)
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblIndent1", { fg = mocha.surface2 })
        vim.api.nvim_set_hl(0, "IblIndent2", { fg = mocha.lavender })
        vim.api.nvim_set_hl(0, "IblIndent3", { fg = mocha.blue })
        vim.api.nvim_set_hl(0, "IblIndent4", { fg = mocha.pink })
        vim.api.nvim_set_hl(0, "IblIndent5", { fg = mocha.teal })
        vim.api.nvim_set_hl(0, "IblIndent6", { fg = mocha.yellow })
      end)

      ibl.setup {
        indent = {
          char = "│",
          highlight = { "IblIndent1", "IblIndent2", "IblIndent3", "IblIndent4", "IblIndent5", "IblIndent6" },
          smart_indent_cap = true,
        },
        whitespace = {
          remove_blankline_trail = true,
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          highlight = { "IblIndent2" }, -- Usar grupo de highlight, no color directo
        },
      }
    end
  end,
}
