return {
    'williamboman/mason.nvim',
    opts = {
      -- Automatically install LSPs for the following languages
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

        -- dap
        'js-debug-adapter',
        'codelldb',
      },
    },
    'williamboman/mason-lspconfig.nvim',
}
