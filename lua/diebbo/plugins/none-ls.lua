return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    null_ls.setup {
      sources = {
        -- formatting
        formatting.stylua,
        formatting.prettier,
        formatting.isort,
        formatting.black,
        formatting.clang_format,

        -- diagnostics
        diagnostics.eslint_d,

      },
    }

    vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { silent = true, noremap = true, desc = 'format document' })
  end,
}
