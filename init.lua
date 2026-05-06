vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true

vim.g.autoformat = true
vim.g.autolint = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a' -- enable mouse mode, can be useful for resizing splits for example!

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true -- enable break indent

vim.opt.undofile = true -- save undo history

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- show which line your cursor is on
vim.opt.cursorline = true

-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- enable line wrapping
vim.opt.wrap = true

-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
    },
  },
  virtual_text = true, -- show inline diagnostics
}

-- INFO: keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- exit terminal mode
map('n', '<leader>us', '<cmd>setlocal spell!<CR>', { desc = 'Toggle spell check' }) -- spellcheck
map('n', '<leader>it', '<cmd>setlocal spell spelllang=it<CR>', { desc = 'Toggle spell check italian' })
map('n', '<leader><leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader><leader>q', '<cmd>q!<CR>', { desc = 'Quit' })
map('n', '<leader><leader>s', '<cmd>wqa<CR>', { desc = 'Save all and exit' })

map('v', '<leader>ns', function()
  require('diebbo.snippets-creator').create_from_visual()
end, { desc = 'New snippet from selection' })

map('n', '<leader>tw', '<cmd>set wrap!<CR>', { desc = 'Toggle Wrap', silent = true })

map('n', 'z0', '1z=', { desc = 'Fix word under cursor' }) -- Fix spelling (picks first suggestion)

map('n', '<leader><leader>a', 'gg<S-v>G', { desc = 'Select all' }) -- select all

map('n', '<leader>fw', ':Floatwin<CR>', { noremap = true, silent = true, desc = 'Toggle floating window' }) -- float term with lazy git
map('n', '<leader>ft', ':Floaterm<CR>', { noremap = true, silent = true, desc = 'Toggle floating terminal' })

map('n', '<leader>gg', ':Floatgit<CR>', { noremap = true, silent = true, desc = 'Toggle floating lazygit' })

map('n', '<leader>km', function() -- Open a floating windows with nvim keymaps file
  local keymaps_file = vim.fn.stdpath 'config' .. '/lua/diebbo/keymaps.lua'
  vim.cmd 'Floatwin'
  vim.cmd('edit ' .. keymaps_file)
end, { desc = 'Show keymaps' })

-- INFO: plugins
local gh = 'https://github.com/'

vim.pack.add({
  'https://github.com/oskarnurm/koda.nvim',
}, { confirm = false })

-- require('koda').setup { transparent = true }
vim.cmd 'colorscheme koda'

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' }, { confirm = false })

require('nvim-treesitter.install').update 'all'
require('nvim-treesitter.config').setup {
  sync_install = true,
  modules = {},
  ignore_install = {},
  ensure_installed = {
    'lua',
    'c',
    'rust',
    'go',
    'typst',
  },
  auto_install = true, -- autoinstall languages that are not installed yet
  highlight = {
    enable = true,
  },
}

vim.pack.add {
  { src = 'https://github.com/saghen/blink.lib' },
  { src = 'https://github.com/saghen/blink.cmp' },
  gh .. 'L3MON4D3/LuaSnip', -- add this
}

-- load your custom snippets directory
require('luasnip.loaders.from_lua').load {
  paths = vim.fn.stdpath 'config' .. '/snip',
}

require 'snippets.creator'

map('n', '<leader>ns', '<cmd>SnipNew<CR>', { desc = 'New snippet for current filetype' })

map('v', '<leader>ns', '<cmd>SnipFromSel<CR>', { desc = 'New snippet from selection' })

require('blink.cmp').setup {
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  signature = { enabled = true },
  snippets = { preset = 'luasnip' },
  keymap = {
    -- these are the default blink keymaps
    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-y>'] = { 'select_and_accept', 'fallback' },
    ['<C-e>'] = { 'cancel', 'fallback' },

    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<Esc>'] = { 'cancel', 'hide_documentation', 'fallback' },

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },

  fuzzy = {
    implementation = 'lua',
  },
}

-- INFO: lsp server installation and configuration
local lsp_servers = {
  lua_ls = {
    -- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file('lua', true) } },
  },
  tinymist = {},
  clangd = {},
  basedpyright = {
    basedpyright = {
      analysis = {
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
          functionParameterTypes = true,
        },
        capabilities = {
          textDocument = {
            publishDiagnostics = {
              tagSupport = {
                valueSet = { 2 },
              },
            },
          },
        },
      },
    },
    python = {
      analysis = {
        typeCheckingMode = 'basic', -- can be "off", "basic", or "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  bashls = {
    filetypes = { 'sh', 'bash' },
  },
  rust_analyzer = {},
  gopls = {},
  ts_ls = {},
  tinymist = {},
  html = {},
  cssls = {},
  jsonls = {},
  yamlls = {},
  marksman = {},
}

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig', -- default configs for lsps

  'https://github.com/mason-org/mason.nvim', -- package manager
  'https://github.com/mason-org/mason-lspconfig.nvim', -- lspconfig bridge
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim', -- auto installer
  gh .. 'stevearc/conform.nvim',
  gh .. 'mfussenegger/nvim-lint',
}, { confirm = false })

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup {
  ensure_installed = vim.tbl_extend('force', vim.tbl_keys(lsp_servers), {
    'stylua',
    'black',
    'isort',
    'ruff',
    'gofumpt',
    'staticcheck',
    'prettier',
    'eslint_d',
    'clang-format',
    'shfmt',
    'shellcheck',
    'typstyle',
    'luacheck',
    'stylelint',
    'yamllint',
    'markdownlint',
  }),
}

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,

    -- only create the keymaps if the server attaches successfully
    on_attach = function(_, bufnr)
      vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'vim.lsp.buf.definition()' })

      vim.keymap.set('n', 'grf', vim.lsp.buf.format, { buffer = bufnr, desc = 'vim.lsp.buf.format()' })
    end,
  })
end

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    rust = { 'rustfmt' },
    go = { 'gofumpt' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    typst = { 'typstyle' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    html = { 'prettier' },
    css = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
  },
  format_on_save = function()
    if not vim.g.autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    if vim.g.autolint then
      require('lint').try_lint()
    end
  end,
})

-- keymaps
map('n', '<leader>tf', function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify('autoformat ' .. (vim.g.autoformat and 'enabled' or 'disabled'))
end, { desc = 'Toggle autoformat' })

map('n', '<leader>tl', function()
  vim.g.autolint = not vim.g.autolint
  vim.notify('autolint ' .. (vim.g.autolint and 'enabled' or 'disabled'))
end, { desc = 'Toggle autolint' })

vim.keymap.set('n', 'grf', function()
  require('conform').format { async = true, lsp_fallback = true }
end, { buffer = bufnr, desc = 'Format buffer' })

-- require("lint").setup({})

-- nvim-lint is configured directly, not via setup()
require('lint').linters_by_ft = {
  lua = { 'luacheck' },
  python = { 'ruff' },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  sh = { 'shellcheck' },
  bash = { 'shellcheck' },
  css = { 'stylelint' },
  yaml = { 'yamllint' },
  markdown = { 'markdownlint' },
}

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
  callback = function()
    require('lint').try_lint()
  end,
})

-- INFO: fuzzy finder
vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim', -- library dependency
  'https://github.com/nvim-tree/nvim-web-devicons', -- icons (nerd font)
  'https://github.com/nvim-telescope/telescope.nvim', -- the fuzzy finder
}, { confirm = false })

require('telescope').setup {}

local pickers = require 'telescope.builtin'

map('n', '<leader>sp', pickers.builtin, { desc = '[S]earch Builtin [P]ickers' })
map('n', '<leader>sb', pickers.buffers, { desc = '[S]earch [B]uffers' })
map('n', '<leader>sf', pickers.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sw', pickers.grep_string, { desc = '[S]earch Current [W]ord' })
map('n', '<leader>sg', pickers.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sr', pickers.resume, { desc = '[S]earch [R]esume' })
map('n', '<leader>sh', pickers.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sm', pickers.man_pages, { desc = '[S]earch [M]anuals' })
map('n', '<leader>sc', function()
  pickers.live_grep {
    prompt_title = 'Search in init.lua',
    search_dirs = { vim.fn.stdpath 'config' .. '/init.lua' },
  }
end, { desc = 'Search in init.lua' })

-- INFO: better statusline
vim.pack.add({ 'https://github.com/nvim-lualine/lualine.nvim' }, { confirm = false })

require('lualine').setup {
  options = {
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
}

-- INFO: keybinding helper
vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })

require('which-key').setup {
  spec = {
    { '<leader>s', group = '[S]earch', icon = { icon = '', color = 'green' } },
  },
}

-- NOTE: there are many more quality-of-life plugins available and others that
-- achieve what these do. these are just our recommendations to start.

-- INFO: utility plugins
vim.pack.add({
  'https://github.com/windwp/nvim-autopairs', -- auto pairs
  'https://github.com/folke/todo-comments.nvim', -- highlight TODO/INFO/WARN comments
  gh .. 'norcalli/nvim-colorizer.lua',
  gh .. 'zbirenbaum/copilot.lua',
}, { confirm = false })

require('nvim-autopairs').setup()
require('todo-comments').setup()
require('colorizer').setup()
require('copilot').setup {
  filetypes = {
    ['*'] = false, -- Disable for all file types by default
    ['lua'] = true,
    ['python'] = true,
    ['javascript'] = true,
    ['typescript'] = true,
    ['go'] = true,
    ['rust'] = true,
    ['java'] = true,
    ['c'] = true,
    ['cpp'] = true,
    ['typst'] = true,
  },
  -- copilot_model = "Claude Sonnet 4.6",
}
local cop_sugg = require 'copilot.suggestion'
map('i', '<C-g>', cop_sugg.accept_line, { expr = true, silent = true })
map('i', '<C-t>', cop_sugg.accept_word, { noremap = true, silent = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuOpen',
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'BlinkCmpMenuClose',
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

-- uncomment to enable automatic plugin updates
-- vim.pack.update()
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = function()
    -- typst-specific settings
    vim.opt_local.textwidth = 0 -- example: disable hard wrap for typst
    vim.opt_local.wrap = true

    -- add tinymist lsp (just add it to your lsp_servers table instead,
    -- but if you want it isolated here:)
    vim.lsp.config('tinymist', {
      settings = {},
      on_attach = function(_, bufnr)
        vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set('n', 'grf', vim.lsp.buf.format, { buffer = bufnr })
      end,
    })
    vim.lsp.enable 'tinymist'
  end,
})
