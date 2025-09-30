return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'typst',
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.shiftwidth = 2
        vim.keymap.set('n', '<leader>tp', '<cmd>TypstPreview<CR>', {
          desc = 'Typst Preview',
          buffer = true,
        })
      end,
    })
  end,
}
