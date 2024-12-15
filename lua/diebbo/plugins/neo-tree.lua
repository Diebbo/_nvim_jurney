return {
  {
    enabled = false,
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })
      require('neo-tree').setup {
        -- closes neotree automatically when it's the last **WINDOW** in the view
        auto_close = true,
        -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        open_on_tab = false,
        -- hijacks new directory buffers when they are opened.
        update_to_buf_dir = {
          -- enable the feature
          enable = false,
          -- allow to open the tree if it was previously closed
          auto_open = true,
        },
        -- hijacks new directory buffers when they are opened.
        hijack_cursor = false,
        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        update_cwd = false,
        -- show lsp diagnostics in the signcolumn
        lsp_diagnostics = true,
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
          -- enables the feature
          enable = true,
          -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
          -- only relevant when `update_focused_file.enable` is true
          update_cwd = true,
          -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
          -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
          ignore_list = {},
        },
        -- configuration options for the system open command (`s` in the tree by default)
        system_open = {
          -- the command to run this, leaving nil should work in most cases
          cmd = nil,
          -- the command arguments as a list
          args = {},
        },
        -- configuration options for the tree icons
        icons = {
          -- specify custom icons for specific filetypes and symlink types
          -- default = {
          --   symlink = "",
          --   git = {
          --     unstaged = "✗",
          --     staged = "✓",
          --     unmerged = "",
          --     renamed = "➜",
          --     untracked = "★",
          --     deleted = "",
          --     ignored = "◌",
          --
          -- },
          -- },
        },

        -- keybindings
        vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true }),
      }
    end,
  },
}
