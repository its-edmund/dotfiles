vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
               {desc = 'Open diagnostic [Q]uickfix list'})

-- Buffer management
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')
vim.keymap.set('n', '<Tab>', ':bnext<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', {noremap = true, silent = true})

-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>',
               {desc = 'Move focus to the left window'})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>',
               {desc = 'Move focus to the right window'})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>',
               {desc = 'Move focus to the lower window'})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>',
               {desc = 'Move focus to the upper window'})

vim.keymap.set('n', '<C-c>', ':%yank +<CR>', {noremap = true, silent = true})

-- System clipboard shortcut
vim.keymap.set('n', '<Leader>y', '"+y', {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>p', '"+p', {noremap = true, silent = true})
