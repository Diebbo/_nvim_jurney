-- keymaps
vim.g.mapleader = ' '

local km = vim.keymap

-- back to explorer
km.set('', '<leader>pv', ':Ex<CR>')

-- to move around windows in <C-w> + h/j/k/l

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help km.set()`
km.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- back to normal mode
km.set('i', 'jk', '<Esc>')

-- Remap for dealing with word wrap
km.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
km.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
km.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
km.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
km.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
km.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- delte backwork
km.set('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })

-- execute current lua
km.set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'Execute current lua file' })
km.set('n', '<leader>x', ':.lua<CR>', { desc = 'Execute current lua line' })
vim.keymap.set('v', '<leader>x', ':lua <CR>', { desc = 'Execute selected lua code' })

-- oil
vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>Oil<CR>',
  { desc = 'Open oil on current file' })

-- exit terminal mode
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>',
  { desc = 'Exit terminal mode' })

-- [[ Spell check ]]
vim.api.nvim_set_keymap('n', '<leader>us', '<cmd>setlocal spell!<CR>',
  { desc = 'Toggle spell check' })
vim.api.nvim_set_keymap('n', '<leader>it', '<cmd>setlocal spell spelllang=it<CR>',
  { desc = 'Toggle spell check italian' })

-- [[ Save and exit ]]
vim.api.nvim_set_keymap('n', '<leader><leader>w', '<cmd>w<CR>', { desc = 'Save' })
vim.api.nvim_set_keymap('n', '<leader><leader>q', '<cmd>q!<CR>', { desc = 'Quit' })
vim.api.nvim_set_keymap('n', '<leader><leader>s', '<cmd>wqa<CR>', { desc = 'Save all and exit' })


-- [[ Moving in buffers ]]
vim.api.nvim_set_keymap('n', '<leader>n', ':bnext<CR>', { desc = 'Go to next buffer' })
vim.api.nvim_set_keymap('n', '<leader>m', ':bprevious<CR>', { desc = 'Go to previous buffer' })
