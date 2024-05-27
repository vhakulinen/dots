
vim.keymap.set('i', 'jj', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', '<C-d>', '<Del>')

vim.keymap.set('n', '<leader>n', ':noh<CR>')
vim.keymap.set('n', '<space>', 'za')

-- Prev and next in cmdline.
vim.keymap.set('c', '<c-p>', '<Up>')
vim.keymap.set('c', '<c-n>', '<Down>')

-- Tabs
vim.keymap.set('n', '<leader>.t', ':tabnew<CR>')
vim.keymap.set('n', '<A-1>', '1gt')
vim.keymap.set('n', '<A-2>', '2gt')
vim.keymap.set('n', '<A-3>', '3gt')
vim.keymap.set('n', '<A-4>', '4gt')
vim.keymap.set('n', '<A-5>', '5gt')
vim.keymap.set('n', '<A-6>', '6gt')
vim.keymap.set('n', '<A-7>', '7gt')
vim.keymap.set('n', '<A-8>', '8gt')
vim.keymap.set('n', '<A-9>', '9gt')

-- Terminal mode
vim.keymap.set('t', '<c-w>', '<c-\\><c-n><c-w>')

-- Diagnostics
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Diagnostics: open float' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Diagnostics: goto prev' })
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Diagnostics: goto next' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Diagnostics: add to location list' })
