local typst_job = nil

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.typ',
  callback = function()
    if typst_job ~= nil then
      return
    end

    local file = vim.fn.expand '%:p'
    local pdf = vim.fn.expand '%:p:r' .. '.pdf'

    typst_job = vim.fn.jobstart({
      'typst',
      'watch',
      file,
      pdf,
    }, {
      detach = true,
    })

    vim.keymap.set('n', '<leader>tp', function()
      vim.fn.jobstart {
        'sioyek',
        pdf,
      }
    end)
  end,
})
