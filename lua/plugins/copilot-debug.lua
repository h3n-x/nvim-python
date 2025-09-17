-- ========================================================================================
-- Copilot Keymap Debugging and Testing
-- Test different key combinations to find what works
-- ========================================================================================

-- Function to test if a key combination works
local function test_keymap(key, desc)
  vim.keymap.set('i', key, function()
    vim.notify("Key " .. key .. " works! (" .. desc .. ")", vim.log.levels.INFO)
    return key
  end, { expr = true, desc = "Test: " .. desc })
end

-- Test various key combinations
test_keymap('<C-Space>', "Control + Space")
test_keymap('<C-CR>', "Control + Enter") 
test_keymap('<C-y>', "Control + Y")
test_keymap('<C-l>', "Control + L")
test_keymap('<A-Tab>', "Alt + Tab")
test_keymap('<A-Space>', "Alt + Space")
test_keymap('<C-A-Space>', "Control + Alt + Space")

-- Special function to accept Copilot suggestions
local function accept_copilot_suggestion()
  -- Try multiple methods to accept Copilot
  if vim.fn.exists("*copilot#Accept") == 1 then
    local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
    if suggestion and suggestion.text and suggestion.text ~= "" then
      vim.fn["copilot#Accept"]("")
      return ""
    end
  end
  
  -- Fallback: show message that no suggestion is available
  vim.notify("No Copilot suggestion available", vim.log.levels.WARN)
  return ""
end

-- Set up working keymaps for Copilot
vim.keymap.set('i', '<C-l>', accept_copilot_suggestion, { 
  desc = "Accept Copilot suggestion",
  expr = true,
  replace_keycodes = false 
})

vim.keymap.set('i', '<C-Space>', accept_copilot_suggestion, { 
  desc = "Accept Copilot suggestion (Space)",
  expr = true,
  replace_keycodes = false 
})

-- Show current Copilot status
vim.keymap.set('n', '<leader>cT', function()
  print("=== COPILOT DEBUG INFO ===")
  
  -- Check if Copilot is loaded
  local copilot_exists = vim.fn.exists("*copilot#Accept") == 1
  print("Copilot functions available:", copilot_exists)
  
  -- Check current buffer filetype
  local ft = vim.bo.filetype
  print("Current filetype:", ft)
  
  -- Check if Copilot is enabled for this filetype
  if copilot_exists then
    local enabled = vim.fn["copilot#Enabled"]()
    print("Copilot enabled:", enabled)
    
    -- Try to get current suggestion
    local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
    if suggestion and suggestion.text then
      print("Current suggestion length:", string.len(suggestion.text))
      print("Suggestion preview:", string.sub(suggestion.text, 1, 50) .. "...")
    else
      print("No current suggestion")
    end
  end
  
  print("========================")
end, { desc = "Test Copilot status" })

return {}
