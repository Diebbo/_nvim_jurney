return {
  'mfussenegger/nvim-dap',
  config = function ()
    
    -- keymaps
    local dap = require('dap')
    local dap_keymaps = {
      ['<F5>'] = { dap.continue, 'Continue' },
      ['<F10>'] = { dap.step_over, 'Step over' },
      ['<F11>'] = { dap.step_into, 'Step into' },
      ['<F12>'] = { dap.step_out, 'Step out' },
      ['<leader>bb'] = { dap.toggle_breakpoint, 'Toggle breakpoint' },
      ['<leader>du'] = { dap.step_out, 'Step out' },
      ['<leader>dr'] = { dap.repl.open, 'Open REPL' },
      ['<leader>dl'] = { dap.run_last, 'Run last' },
      ['<leader>dc'] = { dap.disconnect, 'Disconnect' },
      ['<leader>ds'] = { dap.close, 'Close' },
      ['<leader>dp'] = { dap.pause, 'Pause' },
      ['<leader>de'] = { dap.set_exception_breakpoints, 'Set exception breakpoints' },
      ['<leader>db'] = { dap.step_back, 'Step back' },
      ['<leader>do'] = { dap.step_over, 'Step over' },
      ['<leader>di'] = { dap.step_into, 'Step into' },
      }
    for k, v in pairs(dap_keymaps) do
      local cmd, desc = unpack(v)
      vim.api.nvim_set_keymap('n', k, '<cmd>lua require"dap".'..cmd..'<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, 'n', k, '<cmd>lua require"dap".'..cmd..'<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('v', k, '<cmd>lua require"dap".'..cmd..'<CR>', { noremap = true, silent = true })
    end
  end
}
