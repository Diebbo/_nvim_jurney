return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
      'allaman/emoji.nvim',
      "saghen/blink.compat",
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji' },
        -- optionally disable cmdline completions
        -- cmdline = {},
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            -- overwrite kind of suggestion
            transform_items = function(ctx, items)
              local kind = require("blink.cmp.types").CompletionItemKind.Text
              for i = 1, #items do
                items[i].kind = kind
              end
              return items
            end,
          },
        },
      },

    },
  }
}
