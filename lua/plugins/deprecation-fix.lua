-- ========================================================================================
-- Deprecation Warnings Suppression
-- Suppresses known warnings from external plugins until they update their APIs
-- ========================================================================================

return {
  -- Suppression helper for known deprecation warnings
  {
    "folke/neodev.nvim", -- This will help with LSP setup and type checking
    config = function()
      require("neodev").setup({
        library = {
          enabled = true,
          runtime = true,
          types = true,
          plugins = { "nvim-dap-ui" },
        },
        setup_jsonls = true,
        lspconfig = true,
        pathStrict = true,
      })
      
      -- Suppress specific deprecation warnings that we can't control
      local notify = vim.notify
      vim.notify = function(msg, level, opts)
        -- Filter out known deprecation warnings from external plugins
        if type(msg) == "string" then
          -- Suppress copilot-cmp client.is_stopped warning
          if msg:match("client%.is_stopped is deprecated") then
            return
          end
          
          -- Suppress project.nvim buf_get_clients warning
          if msg:match("vim%.lsp%.buf_get_clients") then
            return
          end
          
          -- Suppress mason-null-ls vim.validate warning
          if msg:match("vim%.validate is deprecated") then
            return
          end
        end
        
        -- Call original notify for other messages
        return notify(msg, level, opts)
      end
      
      -- Create autocommand to restore notify after plugins load
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          -- Delay restoration to after plugin loading
          vim.defer_fn(function()
            -- We keep the filtered notify to continue suppressing these warnings
          end, 1000)
        end,
      })
    end,
  },
}
