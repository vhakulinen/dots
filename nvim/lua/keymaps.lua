local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('i', 'jj', '<esc>')
map('i', 'jk', '<esc>')

map('n', '<leader>n', ':noh<CR>')


-- Telescope
map('n', '<leader>e', '<cmd>Telescope find_files<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')

map('n', '<space>', 'za')

map('i', '<C-d>', '<Del>')

map('c', '<c-p>', '<Up>', { silent = false })
map('c', '<c-n>', '<Down>', { silent = false })

-- Tabs
map('n', '<leader>.t', ':tabnew<CR>')
map('n', '<A-1>', '1gt')
map('n', '<A-2>', '2gt')
map('n', '<A-3>', '3gt')
map('n', '<A-4>', '4gt')
map('n', '<A-5>', '5gt')
map('n', '<A-6>', '6gt')
map('n', '<A-7>', '7gt')
map('n', '<A-8>', '8gt')
map('n', '<A-9>', '9gt')

-- Terminal mode
map('t', '<c-w>', '<c-\\><c-n><c-w>')

-- Diagnostics
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, opts)
