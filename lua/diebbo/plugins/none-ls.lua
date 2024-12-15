return {
  {
    enabled = false,
    'nvimtools/none-ls.nvim', -- Plugin name
    dependencies = {
      'nvimtools/none-ls-extras.nvim',
    },
    config = function()
      -- Create an autogroup to manage autocmds
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      -- Import null-ls module
      local null_ls = require 'null-ls'

      -- Define built-in sources
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      -- local code_actions = null_ls.builtins.code_actions

      -- Setup null-ls with selected sources
      null_ls.setup {
        sources = {
          -- Formatting sources
          formatting.stylua,
          formatting.isort,
          formatting.black,
          formatting.clang_format,
          formatting.prettier,
          formatting.rustywind,

          -- Diagnostics sources
          require 'none-ls.diagnostics.eslint_d',
          require 'none-ls.diagnostics.ruff', -- requires none-ls-extras.nvim
          diagnostics.mypy,
          -- vue

          -- Code actions sources

          -- format on save
          on_attach = function(client, bufnr)
            if client.supports_method 'textDocument/formatting' then
              vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
              vim.api.nvim_create_autocmd('BufWritePre', {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                  -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                  vim.lsp.buf.format { async = false }
                end,
              })
            end
          end,
        },
      }

      -- Key mapping to format document
      vim.keymap.set('n', '<leader>ff', function()
        vim.lsp.buf.format()
      end, { silent = true, noremap = true, desc = 'format document' })
    end,
  },
}
