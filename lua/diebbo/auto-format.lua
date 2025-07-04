do
  local id = 0
  function toggle_autoformat()
    if id ~= 0 then
      vim.api.nvim_del_autocmd(id)
      id = 0
      vim.notify 'Autoformat disabled'
    else
      id = vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        command = 'lua vim.lsp.buf.format()',
      })
      if id ~= 0 then
        vim.notify 'Autoformat enabled'
      else
        vim.notify 'Failed to enable autoformat'
      end
    end
  end

  function show_format_status()
    if id ~= 0 then
      vim.notify('Autoformat enable' .. id)
    else
      vim.notify 'Autoformat disabled'
    end
  end

  -- vim.keymap.set('n', '<leader>ff', toggle_autoformat, { desc = 'Toggle [F]ormat' })
  -- vim.keymap.set('n', '<leader>fs', show_format_status, { desc = 'Show [F]ormat [S]tatus' })
end
