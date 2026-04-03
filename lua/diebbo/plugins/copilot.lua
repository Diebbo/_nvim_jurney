return {
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_filetypes = {
        ['*'] = false,  -- Disable for all file types by default
        ['lua'] = true,
        ['python'] = true,
        ['javascript'] = true,
        ['typescript'] = true,
        ['go'] = true,
        ['rust'] = true,
        ['java'] = true,
        ['c'] = true,
        ['cpp'] = true,
        ['typst'] = true,
      }
      local set_k = vim.api.nvim_set_keymap
      set_k('i', '<C-g>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true })
      set_k('i', '<C-t>', '<Plug>(copilot-accept-word)', { noremap = true, silent = true })
      vim.g.copilot_no_tab_map = true  -- Disable default tab mapping
      -- activate - deactivate copilot
      set_k('n', '<leader>ge', ':Copilot enable<CR>', { noremap = true, silent = true })
      set_k('n', '<leader>gd', ':Copilot disable<CR>', { noremap = true, silent = true })

    end,
  },
}
