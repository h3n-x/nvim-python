-- ========================================================================================
-- Autocompletion Configuration with nvim-cmp
-- Supports LSP, snippets, buffer, path, and cmdline completion
-- ========================================================================================

return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local luasnip = require("luasnip")
      
      -- Get colors for custom styling
      local colors = require("util.colors")
      
      local function has_words_before()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
        formatting = {
          format = function(entry, vim_item)
            local icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            }
            
            -- Set the icon
            vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
            
            -- Set the source
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              cmdline = "[Cmd]",
            })[entry.source.name]
            
            -- Truncate long completions
            if vim_item.abbr and string.len(vim_item.abbr) > 40 then
              vim_item.abbr = string.sub(vim_item.abbr, 1, 40) .. "..."
            end
            
            return vim_item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
        },
      }
    end,
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      
      local cmp = require("cmp")
      cmp.setup(opts)
      
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })
      
      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
      
      -- Set up custom highlights
      local colors = require("util.colors")
      
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = colors.ui.fg_inactive, strikethrough = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = colors.colors.color3, bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = colors.colors.color3, bold = true })
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = colors.ui.fg_tertiary, italic = true })
      
      -- Kind highlights
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = colors.syntax.variable })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = colors.syntax.interface })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = colors.ui.fg_primary })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = colors.syntax["function"] })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = colors.syntax.method })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = colors.syntax.keyword })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = colors.syntax.property })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = colors.syntax.number })
      vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = colors.syntax.class })
      vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = colors.syntax.type })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = colors.syntax.operator })
      vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = colors.syntax.enum })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = colors.colors.color5 })
      vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = colors.colors.color6 })
      vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = colors.colors.color7 })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = colors.colors.color4 })
      vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = colors.syntax.constant })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = colors.syntax.type })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = colors.syntax.type })
      vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = colors.syntax.field })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = colors.syntax.type })
    end,
  },

  -- Autopairs integration
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
      
      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<s-tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
      
      -- Load custom snippets for our target languages
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      
      -- Python snippets
      ls.add_snippets("python", {
        s("main", {
          t("if __name__ == \"__main__\":"),
          t({ "", "    " }),
          i(1),
        }),
        s("pdb", {
          t("import pdb; pdb.set_trace()"),
        }),
        s("doc", {
          t({ '"""', "" }),
          i(1, "Brief description."),
          t({ "", "", "Args:", "    " }),
          i(2, "param: Description"),
          t({ "", "", "Returns:", "    " }),
          i(3, "Description of return value"),
          t({ "", '"""' }),
        }),
      })
      
      -- Bash snippets
      ls.add_snippets("sh", {
        s("shebang", {
          t("#!/usr/bin/env bash"),
          t({ "", "" }),
          i(1),
        }),
        s("strict", {
          t("set -euo pipefail"),
          t({ "", "" }),
          i(1),
        }),
      })
      
      -- JSON snippets
      ls.add_snippets("json", {
        s("package", {
          t({ "{", '  "name": "' }),
          i(1, "package-name"),
          t({ '",', '  "version": "' }),
          i(2, "1.0.0"),
          t({ '",', '  "description": "' }),
          i(3, "Package description"),
          t({ '",', "}" }),
        }),
      })
    end,
  },
}
