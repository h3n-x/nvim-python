-- ========================================================================================
-- Guess-indent Configuration - Automatic indentation detection
-- Blazing fast indentation style detection for consistent code formatting
-- ========================================================================================

return {
	"NMAC427/guess-indent.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = "GuessIndent",
	keys = {
		{
			"<leader>ci",
			"<cmd>GuessIndent<cr>",
			desc = "Guess indentation",
		},
	},
	opts = {
		-- Enable automatic execution on buffer open
		auto_cmd = true,

		-- Override .editorconfig settings if needed
		override_editorconfig = false,

		-- Exclude specific filetypes
		filetype_exclude = {
			"netrw",
			"tutor",
			"help",
			"man",
			"lspinfo",
			"checkhealth",
			"TelescopePrompt",
			"TelescopeResults",
			"mason",
			"lazy",
			"trouble",
			"notify",
			"NvimTree",
			"Avante",
		},

		-- Exclude specific buffer types
		buftype_exclude = {
			"help",
			"nofile",
			"terminal",
			"prompt",
			"quickfix",
		},

		-- Opciones cuando se detectan tabs
		on_tab_options = {
			["expandtab"] = false,
		},

		-- Opciones cuando se detectan espacios (¡cambio aquí!)
		on_space_options = {
			["expandtab"] = true,
		},
	},

	config = function(_, opts)
		require("guess-indent").setup(opts)

		-- Custom autocommands for better integration
		local augroup = vim.api.nvim_create_augroup("GuessIndentEnhanced", { clear = true })

		-- Show notification when indentation is detected
		vim.api.nvim_create_autocmd("User", {
			group = augroup,
			pattern = "GuessIndentSet",
			callback = function(event)
				local data = event.data
				if data and (vim.g.guess_indent_notify == true) then
					local indent_type = data.expandtab and "spaces" or "tabs"
					local indent_size = data.shiftwidth or data.tabstop or "unknown"
					vim.notify(
						string.format("Indentation set to %s (size: %s)", indent_type, indent_size),
						vim.log.levels.INFO,
						{ title = "Guess Indent", timeout = 2000 }
					)
				end
			end,
		})

		-- Language-specific indentation preferences
		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			pattern = { "python", "yaml", "yml" },
			callback = function()
				vim.opt_local.expandtab = true
				if vim.bo.filetype == "python" then
					vim.opt_local.shiftwidth = 4
					vim.opt_local.tabstop = 4
				else -- YAML
					vim.opt_local.shiftwidth = 2
					vim.opt_local.tabstop = 2
				end
			end,
		})

		-- Initialize notification setting
		if vim.g.guess_indent_notify == nil then
			vim.g.guess_indent_notify = false -- Disabled by default to avoid noise
		end
	end,
}
