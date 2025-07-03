require("lazy").setup(
    {
        { import = "diebbo.plugins" },
        { import = "diebbo.plugins.lsp" },
    },
    {
        checker = {
            enabled = true,
            notify = false,
        },
        change_detection = {
            notify = false,
        },
    }
)

require('diebbo.keymaps')
require('diebbo.settings')
require('diebbo.auto-format')
