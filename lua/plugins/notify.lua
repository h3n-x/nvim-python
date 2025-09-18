-- ========================================================================================
-- Nvim-notify Configuration - Fancy notification manager
-- Enhanced notification system with custom styling and animations
-- ========================================================================================

return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>nh",
			function()
				require("telescope").extensions.notify.notify()
			end,
			desc = "Notification History",
		},
		{
			"<leader>nc",
			function()
				require("notify").clear_history()
			end,
			desc = "Clear Notification History",
		},
	},
	opts = function()
		-- Obtenemos los colores aquí para usarlos en las opciones
		local colors = require("util.colors")
		return {
			stages = "fade_in_slide_out",
			-- Pasamos el valor hexadecimal directamente
			background_colour = colors.colors.background,
			timeout = 3000,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			minimum_width = 50,
			fps = 30,
			icons = {
				DEBUG = "",
				ERROR = "",
				INFO = "",
				TRACE = "✎",
				WARN = "",
			},
			level = 2,
			render = "wrapped-compact",
			top_down = true,
		}
	end,
	init = function()
		vim.notify = require("notify")
	end,
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)

		-- Set as default notify function
		vim.notify = notify

		-- Custom highlights
		local colors = require("util.colors")
		local highlights = {
			NotifyERRORBorder = { fg = colors.ui.error },
			NotifyERRORTitle = { fg = colors.ui.error },
			NotifyERRORIcon = { fg = colors.ui.error },
			NotifyWARNBorder = { fg = colors.ui.warning },
			NotifyWARNTitle = { fg = colors.ui.warning },
			NotifyWARNIcon = { fg = colors.ui.warning },
			NotifyINFOBorder = { fg = colors.ui.info },
			NotifyINFOTitle = { fg = colors.ui.info },
			NotifyINFOIcon = { fg = colors.ui.info },
			NotifyDEBUGBorder = { fg = colors.ui.fg_tertiary },
			NotifyDEBUGTitle = { fg = colors.ui.fg_tertiary },
			NotifyDEBUGIcon = { fg = colors.ui.fg_tertiary },
			NotifyTRACEBorder = { fg = colors.colors.color5 },
			NotifyTRACETitle = { fg = colors.colors.color5 },
			NotifyTRACEIcon = { fg = colors.colors.color5 },
		}
		for group, hl in pairs(highlights) do
			vim.api.nvim_set_hl(0, group, hl)
		end
	end,
}
