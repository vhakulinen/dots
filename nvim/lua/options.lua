vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

-- TODO(ville): listchars

-- Decrease update time. Makes CursorHold happen faster.
opt.updatetime = 500
-- Decrease mapped sequence time. Makes which key popup sooner.
opt.timeoutlen = 300

opt.scrolloff = 4
opt.colorcolumn = '80'
opt.number = true
opt.title = true
opt.expandtab = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.inccommand = 'split'
opt.foldmethod = 'marker'
opt.mouse = 'a'

opt.completeopt = 'menu,menuone,noselect'

opt.background = 'dark'
opt.guifont = 'FiraCode Nerd Font 13'
opt.linespace = 4
vim.cmd[[set guicursor+=a:blinkon640]]

opt.tabstop = 4
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 4
opt.smarttab = true

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Adjust shiftwidth for certain filetypes',
  group = vim.api.nvim_create_augroup('my-quickfix-shiftwidth', { clear = true}),
  pattern = {
    'lua',
    'html',
    'javascript',
    'javascript.jsx',
    'typescript',
    'typescript.tsx',
    'css',
    'scss',
    'typescriptreact',
  },
  callback = function()
    vim.api.nvim_set_option_value('shiftwidth', 2, { scope = 'local' })
  end
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Adjust wrap property for quickfix',
  group = vim.api.nvim_create_augroup('my-quickfix-options', { clear = true }),
  pattern = 'gf',
  callback = function()
    vim.api.nvim_set_option_value('wrap', true, { scope = 'local' })
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('my-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('UIEnter', {
  desc = 'GUI specific configuration',
  group = vim.api.nvim_create_augroup('my-uienter', { clear = true }),
  callback = function()
    local chanid = vim.v.event['chan']
    local chan = vim.api.nvim_get_chan_info(chanid)
    if chan.client and chan.client.name ~= 'gnvim' then
      return
    end

    local gnvim = require('gnvim')

    -- Increase/decrease font.
    vim.keymap.set('n', '<c-+>', function() gnvim.font_size(1) end, { desc = 'Increase font size'})
    vim.keymap.set('n', '<c-->', function() gnvim.font_size(-1) end, { desc = 'Decrease font size'})
  end
})
