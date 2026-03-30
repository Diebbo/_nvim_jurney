return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- reference to lua snippet
      'saghen/blink.compat',
      'L3MON4D3/LuaSnip',
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- show documentation window
      keymap = { preset = 'super-tab', ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' } },

      appearance = {
        -- use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },
      signature = { enabled = true },
      completion = {
        trigger = { show_in_snippet = true },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        ghost_text = { enabled = true, show_with_menu = true },
        accept = {
          auto_brackets = {
            enabled = true,
            default_brackets = { '(', ')' },
            -- override_brackets_for_filetypes = {
            --   lua = { '(', ')' },
            --   python = function(item)
            --     -- Custom logic based on completion item
            --     return item.kind == 'Function' and { '(', ')' } or {}
            --   end,
            -- },
            force_allow_filetypes = { 'rust', 'cpp', 'typst', 'typ' },
            blocked_filetypes = { 'markdown', 'text' },
            kind_resolution = {
              enabled = true,
              blocked_filetypes = { 'vue' },
            },
            semantic_token_resolution = {
              enabled = true,
              timeout_ms = 300,
            },
          },
        },
      },
    },
  },
}
