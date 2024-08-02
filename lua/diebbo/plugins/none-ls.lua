return {
  'nvimtools/none-ls.nvim',  -- Plugin name
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require('null-ls')  -- Import null-ls module

    -- Define built-in sources
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    -- Setup null-ls with selected sources
    null_ls.setup {
      sources = {
        -- Formatting sources
        formatting.stylua,
        formatting.isort,
        formatting.black,
        formatting.clang_format,
        formatting.prettier,

        -- Diagnostics sources
        require("none-ls.diagnostics.eslint_d"), 
        require("none-ls.diagnostics.ruff"), -- requires none-ls-extras.nvim
        diagnostics.mypy,

        -- Code actions sources

      },
    }

    -- Key mapping to format document
    vim.keymap.set('n', '<leader>ff', function() vim.lsp.buf.format() end, { silent = true, noremap = true, desc = 'format document' })
  end,
}
