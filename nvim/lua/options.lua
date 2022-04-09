vim.g.mapleader = ","

local opt = vim.opt


-- filetype plugin indent on
-- syntax enable

-- set lazyredraw

opt.colorcolumn = '80'
opt.number = true
opt.title = true
--
-- set wildmenu
opt.expandtab = true
-- set noautowrite
-- set noautowriteall
-- set nomousehide
opt.relativenumber = true
-- set backspace=indent,eol,start
opt.cursorline = true
opt.wrap = false
-- set listchars+=precedes:<,extends:>
opt.inccommand = 'split'
opt.foldmethod = 'marker'
opt.mouse = 'a'

opt.completeopt = 'menu,menuone,noselect'


-- set background=dark
-- let g:nord_italic = 1
-- let g:nord_underline = 1
-- let g:nord_italic_comments = 1
-- let g:nord_cursor_line_number_background = 1

opt.background = 'dark'
opt.guifont = 'FiraCode Nerd Font:h13'
opt.linespace = 4
vim.cmd[[set guicursor+=a:blinkon640]]

opt.tabstop = 4
opt.softtabstop = 0
opt.expandtab = true
opt.shiftwidth = 4
opt.smarttab = true

vim.cmd[[
  autocmd FileType lua,html,javascript,javascript.jsx,typescript,typescript.tsx,css,scss,typescriptreact setlocal shiftwidth=2
]]

-- Set wrap for quickfix
vim.cmd[[
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END
]]
