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

-- Lsp
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')


-- Telescope
map('n', '<leader>e', '<cmd>Telescope find_files<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')

map('n', '<space>', 'za')

map('i', '<C-d>', '<Del>')

map('c', '<c-p>', '<up>')
map('c', '<c-n>', '<down>')

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
