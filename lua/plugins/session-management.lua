-- ========================================================================================
-- Session Management with auto-session
-- Automatically save and restore sessions for a seamless workflow
-- ========================================================================================

return {
	{
		"rmagatti/auto-session",
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Añadimos la dependencia explícita
		},
		opts = {
			log_level = "error",
			auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "/" },
			auto_session_enable_last_session = true,
			auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
			auto_session_allowed_dirs = {
				"~/dev",
				"~/.config/nvim",
			},
			session_lens = {
				load_on_setup = true,
				theme_conf = { border = true },
				previewer = true,
			},
		},
		config = function(_, opts)
			require("auto-session").setup(opts)

			-- Atajos de teclado para gestionar sesiones
			vim.keymap.set("n", "<leader>qs", function()
				require("auto-session.session-lens").search_session()
			end, { desc = "Buscar Sesiones" }) -- q por "quit/session"
			vim.keymap.set("n", "<leader>qd", require("auto-session").delete_session, { desc = "Eliminar Sesión" }) -- d por "delete"
		end,
	},
}
