-- ========================================================================================
-- Autocommands Configuration
-- Comportamientos automatizados para un flujo de trabajo mejorado.
-- ========================================================================================

local api = vim.api

-- Función para crear un grupo de autocomandos de forma limpia
local function augroup(name)
	return api.nvim_create_augroup("h3n_cfg_" .. name, { clear = true })
end

-- Resaltar texto al hacer "yank" (copiar)
api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})

-- Redimensionar splits automáticamente al cambiar el tamaño de la ventana
api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- Recordar la última posición del cursor en un archivo
api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_location"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
			return
		end
		vim.b[buf].last_loc = true
		local mark = api.nvim_buf_get_mark(buf, '"')
		local line_count = api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Permitir cerrar ventanas especiales con la tecla 'q'
api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Activar auto-wrap y corrector ortográfico para archivos de texto
api.nvim_create_autocmd("FileType", {
	group = augroup("text_files"),
	pattern = { "gitcommit", "markdown", "txt" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Configuración para la terminal integrada
api.nvim_create_autocmd("TermOpen", {
	group = augroup("terminal"),
	pattern = "term://*",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert")
	end,
})

-- Crear directorios automáticamente al guardar un archivo en una ruta nueva
api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
