-- ========================================================================================
-- nvim-colorizer.lua - Muestra vistas previas de colores
-- Configuración simplificada para una carga eficiente.
-- ========================================================================================

return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		filetypes = {
			"css",
			"scss",
			"html",
			"javascript",
			"typescript",
			"lua",
			"python",
			"yaml",
			"toml",
		},
		user_default_options = {
			mode = "background",
			tailwind = "both",
			sass = { enable = true, parsers = { "css" } },
		},
	},
	config = function(_, opts)
		require("colorizer").setup(opts)
		-- Atajo de teclado para activar/desactivar
		vim.keymap.set("n", "<leader>uc", "<cmd>ColorizerToggle<cr>", { desc = "Alternar Vista Previa de Colores" })
	end,
}
