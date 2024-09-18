return {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'williamboman/mason.nvim',
        'leoluz/nvim-dap-go',
        'mxsdev/nvim-dap-vscode-js',
    },
    config = function()
        -- require('mason-nvim-dap').setup {
        --     automatic_setup = true,
        --     handlers = {},
        --     event = "VeryLazy",
        --     ensure_installed = {
        --         'delve',
        --         'js-debug-adapter',
        --         'codelldb',
        --     },
        -- }
    end,
}
