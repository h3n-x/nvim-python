-- ========================================================================================
-- Lazygit - Interfaz de Git Completa
-- Una interfaz de terminal para Git que facilita la gestión de tu repositorio.
-- ========================================================================================

return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- Opcional: dependencias para una mejor integración
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- Opcional: personaliza los colores para que coincidan con tu tema
	config = function()
		local colors = require("util.colors")
		vim.g.lazygit_floating_window_winblend = 10
		vim.g.lazygit_floating_window_border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
		vim.g.lazygit_floating_window_use_plenary = 1
		vim.g.lazygit_use_neovim_remote = 1

		-- Highlights personalizados
		vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = colors.ui.border })
		vim.api.nvim_set_hl(0, "LazyGitNormal", { bg = colors.ui.bg_sidebar })
	end,
}
