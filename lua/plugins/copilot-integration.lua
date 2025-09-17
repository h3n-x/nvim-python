-- ========================================================================================
-- Copilot Integration Autocommands and Additional Configuration
-- Better integration between GitHub Copilot and nvim-cmp
-- ========================================================================================

-- Setup autocmds for Copilot integration
local function setup_copilot_integration()
  local augroup = vim.api.nvim_create_augroup("CopilotIntegration", { clear = true })
  
  -- Ensure Copilot is enabled for supported filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
      "python", "lua", "vim", "javascript", "typescript", "javascriptreact", "typescriptreact",
      "css", "scss", "html", "json", "yaml", "toml", "bash", "sh", "sql", "markdown",
      "go", "rust", "c", "cpp", "java", "php", "ruby"
    },
    callback = function()
      -- Enable Copilot for this buffer
      vim.b.copilot_enabled = true
      
      -- Set up buffer-local keymaps for better Copilot experience
      local opts = { buffer = true, silent = true }
      
      -- Alternative accept mapping if C-S-Tab doesn't work
      vim.keymap.set('i', '<C-g>', function()
        if vim.fn.exists("*copilot#Accept") == 1 then
          return vim.fn["copilot#Accept"]("")
        else
          return "<Tab>"
        end
      end, { buffer = true, expr = true, replace_keycodes = false })
      
      -- Show Copilot status
      vim.keymap.set('n', '<leader>cs', function()
        local status = vim.fn.exists("*copilot#Enabled") == 1 and vim.fn["copilot#Enabled"]() or false
        vim.notify("Copilot status: " .. (status and "Enabled" or "Disabled"), vim.log.levels.INFO)
      end, { buffer = true, desc = "Show Copilot status" })
      
      -- Toggle Copilot for current buffer
      vim.keymap.set('n', '<leader>ct', function()
        if vim.fn.exists("*copilot#Enabled") == 1 then
          if vim.fn["copilot#Enabled"]() then
            vim.cmd("Copilot disable")
            vim.notify("Copilot disabled for this buffer", vim.log.levels.INFO)
          else
            vim.cmd("Copilot enable")
            vim.notify("Copilot enabled for this buffer", vim.log.levels.INFO)
          end
        end
      end, { buffer = true, desc = "Toggle Copilot" })
    end,
  })
  
  -- Setup highlights for Copilot suggestions
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    callback = function()
      local colors = require("util.colors")
      vim.api.nvim_set_hl(0, "CopilotSuggestion", { 
        fg = colors.ui.comments, 
        italic = true 
      })
      vim.api.nvim_set_hl(0, "CopilotAnnotation", { 
        fg = colors.colors.color5, 
        italic = true 
      })
    end,
  })
end

-- Function to check Copilot status
local function check_copilot_status()
  local status = {}
  
  -- Check if Copilot is available
  if vim.fn.exists("*copilot#Enabled") == 1 then
    status.available = true
    status.enabled = vim.fn["copilot#Enabled"]()
    status.buffer_enabled = vim.b.copilot_enabled or false
  else
    status.available = false
    status.enabled = false
    status.buffer_enabled = false
  end
  
  return status
end

-- Function to restart Copilot if it's not working
local function restart_copilot()
  vim.cmd("Copilot disable")
  vim.defer_fn(function()
    vim.cmd("Copilot enable")
    vim.notify("Copilot restarted", vim.log.levels.INFO)
  end, 1000)
end

-- Global keymaps for Copilot management
vim.keymap.set('n', '<leader>cpr', restart_copilot, { desc = "Restart Copilot" })
vim.keymap.set('n', '<leader>cps', function()
  local status = check_copilot_status()
  local message = string.format(
    "Copilot Status:\n- Available: %s\n- Enabled: %s\n- Buffer Enabled: %s",
    status.available and "Yes" or "No",
    status.enabled and "Yes" or "No",
    status.buffer_enabled and "Yes" or "No"
  )
  vim.notify(message, vim.log.levels.INFO)
end, { desc = "Check Copilot status" })

-- Initialize the integration
setup_copilot_integration()

return {}
