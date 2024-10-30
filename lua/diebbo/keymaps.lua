-- keymaps
vim.g.mapleader = ' '

-- back to explorer
vim.keymap.set('', '<leader>pv', ':Ex<CR>')

-- to move around windows in <C-w> + h/j/k/l

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- back to normal mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- delte backwork
vim.keymap.set('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })

-- [[ Plugin Keymaps ]]
vim.keymap.set('n', '<leader>cqq', function()
	local input = vim.fn.input('Quick Chat: ')
	if input ~= '' then
		require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
	end
end, { desc = 'CopilotChat - Quick chat' })
