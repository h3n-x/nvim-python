-- ========================================================================================
-- Visual Toggles - Alterna elementos de la UI para una experiencia sin distracciones.
-- Gestionado como un plugin para carga diferida.
-- ========================================================================================

return {
	"folke/which-key.nvim", -- Dependencia para asegurar que los atajos se registren
	event = "VeryLazy",
	config = function()
		local M = {}

		-- Función para alternar la línea del cursor
		M.toggle_cursorline = function()
			vim.opt.cursorline = not vim.opt.cursorline:get()
			vim.notify(
				"Línea del cursor " .. (vim.opt.cursorline:get() and "activada" or "desactivada"),
				vim.log.levels.INFO
			)
		end

		-- Función para alternar el contexto de treesitter
		M.toggle_context = function()
			local status_ok, context = pcall(require, "treesitter-context")
			if status_ok then
				context.toggle()
			else
				vim.notify("Contexto de Treesitter no disponible", vim.log.levels.WARN)
			end
		end

		-- Función para alternar números relativos
		M.toggle_relative_numbers = function()
			vim.opt.relativenumber = not vim.opt.relativenumber:get()
			vim.notify(
				"Números relativos " .. (vim.opt.relativenumber:get() and "activados" or "desactivados"),
				vim.log.levels.INFO
			)
		end

		-- Función para alternar el modo de enfoque
		M.toggle_focus_mode = function()
			local is_focused = not vim.opt.cursorline:get()
			vim.opt.cursorline = is_focused
			vim.opt.relativenumber = is_focused

			local status_ok, context = pcall(require, "treesitter-context")
			if status_ok then
				if is_focused then
					context.enable()
				else
					context.disable()
				end
			end

			vim.notify("Modo Enfoque " .. (is_focused and "Activado" or "Desactivado"), vim.log.levels.INFO)
		end

		-- Configura los atajos de teclado
		vim.keymap.set("n", "<leader>tl", M.toggle_cursorline, { desc = "Alternar línea del cursor" })
		vim.keymap.set("n", "<leader>tc", M.toggle_context, { desc = "Alternar contexto de Treesitter" })
		vim.keymap.set("n", "<leader>tn", M.toggle_relative_numbers, { desc = "Alternar números relativos" })
		vim.keymap.set("n", "<leader>tf", M.toggle_focus_mode, { desc = "Alternar modo de enfoque" })
	end,
}
