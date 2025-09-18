-- ========================================================================================
-- Alpha-nvim Configuration - Pantalla de Inicio Personalizada
-- Un dashboard funcional y estético para Neovim.
-- ========================================================================================

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		-- Las dependencias ahora se gestionan en telescope.lua
	},
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local colors = require("util.colors")

		-- ASCII Art "h3n"
		dashboard.section.header.val = {
			"      ██╗  ██╗███████╗███╗   ██╗",
			"      ██║  ██║██╔════╝████╗  ██║",
			"      ███████║█████╗  ██╔██╗ ██║",
			"      ██╔══██║██╔══╝  ██║╚██╗██║",
			"      ██║  ██║███████╗██║ ╚████║",
			"      ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝",
		}

		-- Botones con accesos directos (CORREGIDO)
		dashboard.section.buttons.val = {
			dashboard.button("f", "  Buscar Archivo", "<cmd>Telescope find_files<cr>"),
			dashboard.button("r", "  Archivos Recientes", "<cmd>Telescope oldfiles<cr>"),
			dashboard.button("g", "  Buscar Texto (Grep)", "<cmd>Telescope live_grep<cr>"),
			dashboard.button("s", "  Gestionar Sesiones", "<cmd>Telescope session-lens<cr>"),
			dashboard.button("l", "󱁿  Gestionar Plugins", "<cmd>Lazy<cr>"),
			dashboard.button("q", "  Salir de Neovim", "<cmd>qa<cr>"),
		}

		-- Pie de página con información útil
		local function footer()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return "⚡ Neovim cargó " .. stats.count .. " plugins en " .. ms .. "ms"
		end

		dashboard.section.footer.val = footer()

		-- Configuración de layout y colores
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		dashboard.config.opts.hl = {
			Header = { fg = colors.colors.color4 },
			Button = { fg = colors.ui.fg_primary },
			ButtonText = { fg = colors.ui.fg_primary },
			Footer = { fg = colors.syntax.comment, italic = true },
		}

		return dashboard.config
	end,
	config = function(_, opts)
		require("alpha").setup(opts)

		-- Ocultar la statusline y tabline en el dashboard
		vim.api.nvim_create_autocmd("User", {
			pattern = "AlphaReady",
			callback = function()
				vim.cmd("set showtabline=0 | set laststatus=0")
				vim.api.nvim_create_autocmd("BufLeave", {
					pattern = "alpha",
					once = true,
					callback = function()
						vim.cmd("set showtabline=2 | set laststatus=3")
					end,
				})
			end,
		})
	end,
}
