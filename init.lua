-- ========================================================================================
-- Neovim Configuration - Shades of Purple Theme + Catppuccin Base
-- Optimized for Arch Linux + Hyprland
-- Languages: Python, Markdown, CSS, SQL, Bash, JSON, TOML, YAML
-- ========================================================================================

-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim with plugin specifications
require("lazy").setup({
  spec = {
    -- Import all plugin specs from plugins/ directory
    { import = "plugins" },
  },
  defaults = {
    lazy = false, -- should plugins be lazy-loaded by default?
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load the colorscheme after plugins are loaded
vim.schedule(function()
  pcall(vim.cmd.colorscheme, "catppuccin")
end)
