return {
  'APZelos/blamer.nvim',
  config = function ()
    vim.g.blamer_enabled = 1
    vim.g.blamer_delay = 500
    vim.g.blamer_prefix = ''
    vim.g.blamer_show_in_visual_modes = 0
    vim.g.blamer_show_in_insert_modes = 1
    vim.g.blamer_show_in_replace_modes = 0
    vim.g.blamer_show_in_normal_modes = 0
  end
}
