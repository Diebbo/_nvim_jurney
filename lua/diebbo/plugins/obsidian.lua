return {
  {
    enabled = true,
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      --   -- refer to `:h file-pattern` for more examples
      'BufReadPre '
      .. vim.fn.expand '~'
      .. '/obsidian/note-di-diebbo/*.md',
      --   "BufNewFile /home/diebbo/obsidian/Note di Diebbo/*.md",
    },
    opts = {
      workspace = {
        name = 'obsidian',
        path = '~/obsidian/note-di-diebbo',
      },
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },
    },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
    },
  },
}
