-- keymaps
vim.g.mapleader = ' '

local km = vim.keymap
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- back to explorer
km.set('', '<leader>pv', ':Ex<CR>')


-- Keymaps for better default experience
km.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- back to normal mode
km.set('i', 'jk', '<Esc>')

-- Remap for dealing with word wrap
km.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
km.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- km.set('n', '[d', vim.diagnostic.go, { desc = 'Go to previous diagnostic message' })
-- km.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
km.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
km.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- delte backwork
km.set('i', '<C-BS>', '<C-w>', { noremap = true, silent = true })

-- execute current lua
km.set('n', '<space><space>x', '<cmd>source %<CR>', { desc = 'Execute current lua file' })
km.set('n', '<leader>x', ':.lua<CR>', { desc = 'Execute current lua line' })
map('v', '<leader>x', ':lua <CR>', { desc = 'Execute selected lua code' })

-- oil
map('n', '<leader>o', '<cmd>Oil<CR>', { desc = 'Open oil on current file' })

-- exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ Spell check ]]
map('n', '<leader>us', '<cmd>setlocal spell!<CR>', { desc = 'Toggle spell check' })
map('n', '<leader>it', '<cmd>setlocal spell spelllang=it<CR>', { desc = 'Toggle spell check italian' })

-- [[ Save and exit ]]
map('n', '<leader><leader>w', '<cmd>w<CR>', { desc = 'Save' })
map('n', '<leader><leader>q', '<cmd>q!<CR>', { desc = 'Quit' })
map('n', '<leader><leader>s', '<cmd>wqa<CR>', { desc = 'Save all and exit' })

-- [[ Moving in buffers ]]

map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })


-- [[ Snippets creator ]]
map('n', '<leader>ns', function()
  require('diebbo.snippets-creator').create()
end, { desc = 'New snippet for current filetype' })

map('v', '<leader>ns', function()
  require('diebbo.snippets-creator').create_from_visual()
end, { desc = 'New snippet from selection' })

-- Quick switch to last edited file (super useful!)
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Resize windows with Ctrl+Shift+arrows (macOS friendly)
map("n", "<C-S-Up>", "<cmd>resize +5<CR>", opts)
map("n", "<C-S-Down>", "<cmd>resize -5<CR>", opts)
map("n", "<C-S-Left>", ":vertical resize +5<CR>", opts)
map("n", "<C-S-Right>", ":vertical resize -5<CR>", opts)

-- Toggle line wrapping
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap", silent = true })

-- Fix spelling (picks first suggestion)
map("n", "z0", "1z=", { desc = "Fix word under cursor" })

-- select all
map("n", "<leader><leader>a", "gg<S-v>G", { desc = "Select all" })


map("n", "<leader>fw", ":Floatwin<CR>",
  { noremap = true, silent = true, desc = "Toggle floating window" })
-- float term with lazy git
map("n", "<leader>ft", ":Floaterm<CR>",
  { noremap = true, silent = true, desc = "Toggle floating terminal" })

map("n", "<leader>gg", ":Floatgit<CR>",
  { noremap = true, silent = true, desc = "Toggle floating lazygit" })

-- Open a floating windows with nvim keymaps file
map("n", "<leader>km", function()
  local keymaps_file = vim.fn.stdpath("config") .. "/lua/diebbo/keymaps.lua"
  vim.cmd("Floatwin")
  vim.cmd("edit " .. keymaps_file)
end, { desc = "Show keymaps" })
