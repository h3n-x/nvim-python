-- ========================================================================================
-- Visual Adjustments - Toggle UI elements that might be distracting
-- ========================================================================================

-- Function to toggle cursor line
local function toggle_cursorline()
  vim.opt.cursorline = not vim.opt.cursorline:get()
  local status = vim.opt.cursorline:get() and "enabled" or "disabled"
  vim.notify("Cursor line " .. status, vim.log.levels.INFO)
end

-- Function to toggle treesitter context
local function toggle_context()
  local status_ok, context = pcall(require, "treesitter-context")
  if status_ok then
    context.toggle()
  else
    vim.notify("Treesitter context not available", vim.log.levels.WARN)
  end
end

-- Function to toggle relative numbers
local function toggle_relative_numbers()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
  local status = vim.opt.relativenumber:get() and "enabled" or "disabled"
  vim.notify("Relative numbers " .. status, vim.log.levels.INFO)
end

-- Function to toggle color column
local function toggle_colorcolumn()
  local current = vim.opt.colorcolumn:get()
  if #current == 0 then
    -- Activate based on filetype
    local ft = vim.bo.filetype
    if ft == "python" then
      vim.opt_local.colorcolumn = "89"
    elseif ft == "markdown" then
      vim.opt_local.colorcolumn = "81"
    else
      vim.opt_local.colorcolumn = "80"
    end
    vim.notify("Color column enabled", vim.log.levels.INFO)
  else
    vim.opt_local.colorcolumn = ""
    vim.notify("Color column disabled", vim.log.levels.INFO)
  end
end

-- Function to toggle all visual distractions
local function toggle_focus_mode()
  -- Toggle multiple UI elements for a cleaner look
  local current_cursorline = vim.opt.cursorline:get()
  
  vim.opt.cursorline = not current_cursorline
  vim.opt.relativenumber = not current_cursorline
  
  -- Toggle treesitter context
  local status_ok, context = pcall(require, "treesitter-context")
  if status_ok then
    if current_cursorline then
      context.disable()
    else
      context.enable()
    end
  end
  
  local mode = current_cursorline and "Focus Mode ON" or "Focus Mode OFF"
  vim.notify(mode .. " - Distractions " .. (current_cursorline and "hidden" or "visible"), vim.log.levels.INFO)
end

-- Setup keymaps for visual toggles
vim.keymap.set('n', '<leader>tl', toggle_cursorline, { desc = "Toggle cursor line" })
vim.keymap.set('n', '<leader>tc', toggle_context, { desc = "Toggle treesitter context" })
vim.keymap.set('n', '<leader>tn', toggle_relative_numbers, { desc = "Toggle relative numbers" })
vim.keymap.set('n', '<leader>tv', toggle_colorcolumn, { desc = "Toggle color column (vertical line)" })
vim.keymap.set('n', '<leader>tf', toggle_focus_mode, { desc = "Toggle focus mode (hide distractions)" })

-- Option to start with focus mode if desired
-- Uncomment the line below to start with minimal distractions
-- vim.defer_fn(toggle_focus_mode, 100)

return {}
