return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local treesitter = require 'nvim-treesitter'
      treesitter.setup()
      local ft = { 'java', 'c', 'lua', 'vim', 'vimdoc', 'query', 'elixir', 'heex', 'javascript', 'typescript', 'html', 'yaml' }
      treesitter.install(ft)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = ft,
        callback = function()
          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- folds, provided by Neovim (I don't like folds)
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      --   vim.defer_fn(function()
      --     require('nvim-treesitter.config').setup {
      --       -- Add languages to be installed here that you want installed for treesitter
      --       ensure_installed = {
      --         'c',
      --         'cpp',
      --         'go',
      --         'lua',
      --         'python',
      --         'rust',
      --         'tsx',
      --         'javascript',
      --         'typescript',
      --         'vimdoc',
      --         'vim',
      --         'bash',
      --         'java',
      --         'cmake',
      --         'markdown',
      --         'markdown_inline',
      --         'r',
      --         'rnoweb',
      --         'yaml',
      --         'vue',
      --         'bibtex',
      --         'latex',
      --       },
      --
      --       -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      --       auto_install = true,
      --
      --       highlight = { enable = true },
      --       indent = { enable = true },
      --       incremental_selection = {
      --         enable = true,
      --         keymaps = {
      --           init_selection = '<c-space>',
      --           node_incremental = '<c-space>',
      --           scope_incremental = '<c-s>',
      --           node_decremental = '<M-space>',
      --         },
      --       },
      --       textobjects = {
      --         select = {
      --           enable = true,
      --           lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      --           keymaps = {
      --             -- You can use the capture groups defined in textobjects.scm
      --             ['aa'] = '@parameter.outer',
      --             ['ia'] = '@parameter.inner',
      --             ['af'] = '@function.outer',
      --             ['if'] = '@function.inner',
      --             ['ac'] = '@class.outer',
      --             ['ic'] = '@class.inner',
      --           },
      --         },
      --         move = {
      --           enable = true,
      --           set_jumps = true, -- whether to set jumps in the jumplist
      --           goto_next_start = {
      --             [']m'] = '@function.outer',
      --             [']]'] = '@class.outer',
      --           },
      --           goto_next_end = {
      --             [']M'] = '@function.outer',
      --             [']['] = '@class.outer',
      --           },
      --           goto_previous_start = {
      --             ['[m'] = '@function.outer',
      --             ['[['] = '@class.outer',
      --           },
      --           goto_previous_end = {
      --             ['[M'] = '@function.outer',
      --             ['[]'] = '@class.outer',
      --           },
      --         },
      --         swap = {
      --           enable = true,
      --           swap_next = {
      --             ['<leader>a'] = '@parameter.inner',
      --           },
      --           swap_previous = {
      --             ['<leader>A'] = '@parameter.inner',
      --           },
      --         },
      --       },
      --     }
      --   end, 0)
    end,
  },
}
