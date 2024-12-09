return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      -- Telescope live_grep in git root
      -- Function to find the git root directory based on the current buffer's path
      local function find_git_root()
        -- Use the current buffer's path as the starting point for the git search
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()
        -- If the buffer is not associated with a file, return nil
        if current_file == '' then
          current_dir = cwd
        else
          -- Extract the directory from the current file's path
          current_dir = vim.fn.fnamemodify(current_file, ':h')
        end

        -- Find the Git root directory from the current file's path
        local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')
            [1]
        if vim.v.shell_error ~= 0 then
          print 'Not a git repository. Searching on current working directory'
          return cwd
        end
        return git_root
      end

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          require('telescope.builtin').live_grep {
            search_dirs = { git_root },
          }
        end
      end

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

      -- [[ Telescope Mappings ]]

      local tbuiltin = require('telescope.builtin')

      local km = vim.keymap

      km.set('n', '<leader>fr', tbuiltin.oldfiles, { desc = '[?] Find recently opened files' })
      km.set('n', '<leader>fb', tbuiltin.buffers, { desc = '[ ] Find existing buffers' })
      km.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        tbuiltin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      km.set('n', '<leader>fg', tbuiltin.git_files, { desc = 'Telescope [F]iles [G]it' })
      km.set('n', '<leader>sf', tbuiltin.find_files, { desc = '[F]ile [S]earch' })
      km.set('n', '<leader>sh', tbuiltin.help_tags, { desc = '[S]earch [H]elp' })
      km.set('n', '<leader>sw', tbuiltin.grep_string, { desc = '[S]earch current [W]ord' })
      km.set('n', '<leader>sg', tbuiltin.live_grep, { desc = '[S]earch by [G]rep' })
      km.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
      km.set('n', '<leader>sd', tbuiltin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      km.set('n', '<leader>sr', tbuiltin.resume, { desc = '[S]earch [R]esume' })
      km.set('n', '<leader>sc', function()
        tbuiltin.find_files({
          prompt_title = 'Search in Nvim Config',
          cwd = vim.fn.stdpath('config'),
        })
      end, { desc = '[S]earch in nvim [C]onfig' })

      -- change theme
      km.set('n', '<leader>ct', function()
        tbuiltin.colorscheme(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[C]olor [T]heme' })
    end,
  },
}
