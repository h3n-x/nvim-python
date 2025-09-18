-- ========================================================================================
-- Yazi.nvim Configuration - File Manager Integration
-- Blazing fast file manager integration with enhanced features
-- ========================================================================================

return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>e",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at current file",
			mode = { "n", "v" },
		},
		{
			"<leader>E",
			"<cmd>Yazi cwd<cr>",
			desc = "Open yazi in current working directory",
		},
		{
			"<leader>fy",
			"<cmd>Yazi<cr>",
			desc = "Open yazi file manager",
			mode = { "n", "v" },
		},
		{
			"<leader>fY",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume last yazi session",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Toggle yazi session",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	---@type YaziConfig
	opts = {
		-- Replace netrw with yazi
		open_for_directories = true,

		-- Open multiple tabs for better navigation
		open_multiple_tabs = true,

		-- Change neovim cwd when yazi closes
		change_neovim_cwd_on_close = true,

		-- Highlight settings
		highlight_groups = {
			hovered_buffer = { link = "Visual" },
			hovered_buffer_in_same_directory = { link = "CursorLine" },
		},

		-- Window configuration
		floating_window_scaling_factor = 0.9,
		yazi_floating_window_winblend = 10,
		yazi_floating_window_border = "rounded",

		-- Logging for debugging
		log_level = vim.log.levels.OFF,

		-- Enhanced keymaps
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			replace_in_directory = "<c-g>",
			cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "<c-\\>",
			open_and_pick_window = "<c-o>",
		},

		-- Clipboard register
		clipboard_register = "*",

		-- Hooks for custom behavior
		hooks = {
			yazi_opened = function(preselected_path, yazi_buffer_id, config)
				vim.notify("Yazi opened at: " .. (preselected_path or "current directory"), "info", {
					title = "File Manager",
					timeout = 2000,
				})
			end,

			yazi_closed_successfully = function(chosen_file, config, state)
				if chosen_file then
					vim.notify("File selected: " .. vim.fn.fnamemodify(chosen_file, ":t"), "info", {
						title = "File Manager",
						timeout = 2000,
					})
				end
			end,

			yazi_opened_multiple_files = function(chosen_files, config, state)
				vim.notify(string.format("Selected %d files", #chosen_files), "info", {
					title = "File Manager",
					timeout = 2000,
				})
				-- Send to quickfix list
				local qf_list = {}
				for _, file in ipairs(chosen_files) do
					table.insert(qf_list, { filename = file, lnum = 1, col = 1 })
				end
				vim.fn.setqflist(qf_list)
				vim.cmd("copen")
			end,
		},

		-- Highlight hovered buffers in same directory
		highlight_hovered_buffers_in_same_directory = true,

		-- Integrations
		integrations = {
			-- Telescope integration for grep
			grep_in_directory = function(directory)
				local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
				if telescope_ok then
					telescope_builtin.live_grep({
						cwd = directory,
						prompt_title = "Grep in " .. vim.fn.fnamemodify(directory, ":t"),
					})
				else
					vim.notify("Telescope not available for grep", "warn", { title = "Yazi" })
				end
			end,

			grep_in_selected_files = function(selected_files)
				local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
				if telescope_ok then
					telescope_builtin.live_grep({
						search_dirs = selected_files,
						prompt_title = "Grep in selected files",
					})
				else
					vim.notify("Telescope not available for grep", "warn", { title = "Yazi" })
				end
			end,

			-- Grug-far integration for replace
			replace_in_directory = function(directory)
				local grug_far_ok, grug_far = pcall(require, "grug-far")
				if grug_far_ok then
					grug_far.open({
						transient = true,
						prefills = {
							paths = directory,
						},
					})
				else
					vim.notify("Grug-far not available for replace", "warn", { title = "Yazi" })
				end
			end,

			replace_in_selected_files = function(selected_files)
				local grug_far_ok, grug_far = pcall(require, "grug-far")
				if grug_far_ok then
					grug_far.open({
						transient = true,
						prefills = {
							paths = table.concat(selected_files, " "),
						},
					})
				else
					vim.notify("Grug-far not available for replace", "warn", { title = "Yazi" })
				end
			end,

			-- Use system realpath
			resolve_relative_path_application = vim.fn.has("mac") == 1 and "grealpath" or "realpath",

			-- Buffer deletion with layout preservation
			bufdelete_implementation = "bundled-snacks",
		},

		-- Future features
		future_features = {
			use_cwd_file = true,
			new_shell_escaping = true,
		},
	},

	config = function(_, opts)
		require("yazi").setup(opts)

		-- Custom commands
		vim.api.nvim_create_user_command("YaziCurrentFile", function()
			require("yazi").yazi(nil, vim.fn.expand("%:p"))
		end, { desc = "Open yazi at current file" })

		vim.api.nvim_create_user_command("YaziCurrentDir", function()
			require("yazi").yazi(nil, vim.fn.expand("%:p:h"))
		end, { desc = "Open yazi at current directory" })

		vim.api.nvim_create_user_command("YaziWorkingDir", function()
			require("yazi").yazi(nil, vim.fn.getcwd())
		end, { desc = "Open yazi at working directory" })

		-- Integration with other plugins
		local augroup = vim.api.nvim_create_augroup("YaziIntegration", { clear = true })

		-- Auto-close nvim-tree when yazi opens
		vim.api.nvim_create_autocmd("User", {
			group = augroup,
			pattern = "YaziOpened",
			callback = function()
				local nvim_tree_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
				if nvim_tree_ok and nvim_tree_api.tree.is_visible() then
					nvim_tree_api.tree.close()
				end
			end,
		})

		-- Restore nvim-tree when yazi closes if it was open before
		vim.api.nvim_create_autocmd("User", {
			group = augroup,
			pattern = "YaziClosed",
			callback = function()
				-- Could implement logic to restore nvim-tree if needed
			end,
		})
	end,

	-- Disable netrw to avoid conflicts
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
