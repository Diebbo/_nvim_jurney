return {
  'rcarriga/nvim-notify',
  config = function()
    vim.notify = require 'notify'

    require('notify').setup {
      stages = 'fade',
      timeout = 3000,
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
      },
      background_colour = '#000000',
    }
  end,
}
