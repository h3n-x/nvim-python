-- ========================================================================================
-- Comment.nvim - Comentarios Inteligentes
-- Atajos para comentar y descomentar código de forma eficiente.
-- ========================================================================================

return {
	"numToStr/Comment.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = function()
		-- Convertimos opts a una función para asegurar la carga de dependencias
		return {
			-- Activa la integración con treesitter para comentarios más precisos
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		}
	end,
	config = function(_, opts)
		require("Comment").setup(opts)

		-- Atajos de teclado recomendados
		local map = vim.keymap.set
		map("n", "<leader>/", function()
			require("Comment.api").toggle.linewise.current()
		end, { desc = "Comentar/Descomentar línea actual" })

		map("v", "<leader>/", function()
			require("Comment.api").toggle.linewise(vim.fn.visualmode())
		end, { desc = "Comentar/Descomentar selección" })
	end,
}
