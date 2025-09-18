-- ========================================================================================
-- Indent Scope Highlighting with mini.indentscope
-- A lightweight and performant alternative to indent-blankline
-- ========================================================================================

return {
	"echasnovski/mini.indentscope",
	version = false, -- Usa la última versión
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		-- Movemos la configuración a una función para que se ejecute después de cargar el plugin
		return {
			-- Símbolos a usar para dibujar las guías de indentación
			symbol = "│",
			-- Opciones de dibujo
			draw = {
				-- Retraso en milisegundos antes de dibujar las guías
				delay = 100,
				-- Animación al cambiar el scope
				animation = require("mini.indentscope").gen_animation.linear({ duration = 100 }),
			},
			-- Mapeos de text-objects para seleccionar/operar sobre el scope actual
			mappings = {
				object_scope = "ii", -- por ejemplo, yii para "yank inner indent"
				object_scope_with_border = "ai",
				goto_top = "[i",
				goto_bottom = "]i",
			},
		}
	end,
	config = function(_, opts)
		require("mini.indentscope").setup(opts)

		-- Integración con el tema para un look cohesivo
		local colors = require("util.colors")
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = colors.ui.border, nocombine = true })
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbolOff", { fg = colors.ui.bg_secondary, nocombine = true })
	end,
}
