return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    -- opts = {
    --   open_cmd = 'sioyek %s',
    -- },
    enabled = false,
    config = function()
      require('typst-preview').setup({
        open_cmd = 'sioyek --new-window %s',
      })

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
  },
}
