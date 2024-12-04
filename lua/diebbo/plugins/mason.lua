return {
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  -- Automatically install LSPs for the following languages
  config = function()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'clangd',
        'gopls',
        'pyright',
        'rust_analyzer',
        'html',
        'cssls',
        'angularls',
        'lua_ls',
        'ruff',
        'mypy',
        'typescript-language-server',
        'eslint-lsp',
        'prettier',
        'vue-language-server',
        'vls',

        -- dap
        'js-debug-adapter',
        'codelldb',
      },
    }
  end,
}
