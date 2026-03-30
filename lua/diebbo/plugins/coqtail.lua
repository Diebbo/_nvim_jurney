return {
  {
    enabled=false,
    'whonore/Coqtail',
    init = function() end,
    config = function()
      vim.api.nvim_set_keymap("i", '<A-n>', '<cmd>RocqNext<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", '<A-n>', '<cmd>RocqNext<CR>', { noremap = true, silent = true })
    end,
  },
}
