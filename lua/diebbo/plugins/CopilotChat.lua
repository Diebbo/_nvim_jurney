return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
  },
  build = 'make tiktoken',        -- Only on MacOS or Linux
  opts = {
    debug = true,                 -- Enable debugging
    window = {
      layout = 'vertical',
      width = 50,
    },
    mappings = {
      close = {
        insert = '',
      },
    },
  },
}
