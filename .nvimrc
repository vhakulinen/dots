" {{{ Plug
call plug#begin('~/.nvim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'vim-scripts/TaskList.vim'
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-airline'
Plug 'whatyouhide/vim-gotham'
Plug 'scrooloose/nerdcommenter'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
" Plug 'benekastah/neomake'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'romainl/Apprentice'
"Plug 'floobits/floobits-neovim'

call plug#end()
" }}}

" {{{ Plugin stuff 
" Go
let g:go_fmt_command = "goimports"

" }}}

" {{{ General
let mapleader=","

filetype on
filetype plugin indent on
syntax on

set lazyredraw

set laststatus=2
set colorcolumn=80
set number
set title
set wildmenu
"set wildmenu=full
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noautowrite
set noautowriteall
set nomousehide
set relativenumber
set backspace=indent,eol,start
set cursorline
set nowrap
set listchars+=precedes:<,extends:>

set foldmethod=marker

set background=dark
colorscheme gotham

autocmd BufWritePost *.py call yapf#YAPF()

" autocmd BufWritePost * :Neomake
" }}}

" {{{ Mappings
" automatic bracets
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap { {}<Esc>:let leavechar="}"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap ' ''<Esc>:let leavechar="'"<CR>i
inoremap " ""<Esc>:let leavechar="\""<CR>i
imap <C-j> <Esc>:exec "normal f" . leavechar<Cr>a
" exit from insert mode
imap jj <esc>
imap jk <esc>
imap kj <esc>

" TagBar
nnoremap <Leader>l :TagbarToggle<CR>

" FZF
" nnoremap <Leader>e :FZF<CR>

" CtrlP
nnoremap <Leader>e :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>a :CtrlPBufTagAll<CR>
" Task lists
map <leader>t <Plug>TaskList

" Terminal mode
" tnoremap <c-q> <c-g><esc>

" space to open/close folds
nnoremap <space> za

inoremap <C-d> <Del>
" tabnew
nnoremap <Leader>.t :tabnew<CR>

" disable arrow keys
inoremap  <up>     <nop>
inoremap  <down>   <nop>
inoremap  <left>   <nop>
inoremap  <right>  <nop>
noremap   <up>     <nop>
noremap   <down>   <nop>
noremap   <left>   <nop>
noremap   <right>  <nop>

" neovim TERMINAL mode mappings
tmap <c-w> <c-\><c-n><c-w>
tmap <c-w><c-c> <c-\><c-n>
au WinEnter term://* startinsert

" }}}
