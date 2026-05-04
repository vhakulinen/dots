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
vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Diagnostics: goto prev' })
vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Diagnostics: goto next' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Diagnostics: add to location list' })

-- Exec lua
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'Lua: execute current line' })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'Lua: execute current selection' })

vim.keymap.set('n', '<leader>se', MiniPick.builtin.files, { desc = 'search files' })
vim.keymap.set('n', '<leader>sg', MiniPick.builtin.grep_live, { desc = 'search by grep' })
vim.keymap.set('n', '<leader>sh', MiniPick.builtin.help, { desc = 'search help' })
vim.keymap.set('n', '<leader>sb', MiniPick.builtin.buffers, { desc = 'search buffers' })

local function instead(msg)
  return function()
    vim.notify(string.format('use %s instead', msg), vim.log.levels.WARN)
  end
end

-- Try to learn the builtin keybinds...
vim.keymap.set('n', '<leader>rn', instead('grn'))
vim.keymap.set('n', '<leader>ca', instead('gra'))
vim.keymap.set('n', '<leader>rf', instead('grr'))
vim.keymap.set('i', '<C-k>', instead('<C-s>'))

vim.keymap.set('n', '<leader>ei', function()
  vim.cmd [[ tabnew ]]
  vim.cmd [[ tcd ~/.config/nvim ]]
  vim.cmd [[ edit init.lua ]]
end)
