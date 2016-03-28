" {{{ Plug
call plug#begin('~/.config/nvim/plugged')

"Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'vim-scripts/TaskList.vim'
Plug 'Yggdroot/indentLine'
Plug 'bling/vim-airline'
Plug 'whatyouhide/vim-gotham'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'benekastah/neomake'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'romainl/Apprentice'
Plug 'tomasr/molokai'
"Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim'
"Plug 'floobits/floobits-neovim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-speeddating'
"Plug 'jceb/vim-orgmode'
Plug 'vim-scripts/utl.vim'
Plug 'kassio/neoterm'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'mhinz/vim-startify'
Plug 'flazz/vim-colorschemes'

call plug#end()
" }}}

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"set runtimepath+=/usr/share/vim/vimfiles
"let g:EclimCompletionMethod = 'omnifunc'
"let g:EclimTempFilesEnable = 1

"autocmd FileType java setlocal omnifunc=javacomplete#Complete

" {{{ Plugin stuff 
" Go
"let g:go_fmt_command = "goimports"

" FZF
let g:fzf_layout = { 'down' : '20%' }

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Neoterm
let g:neoterm_size="10%"

" Airline
let g:airline_powerline_fonts=1

" Neomake
autocmd! BufWritePost * Neomake

" }}}

" {{{ General
let mapleader=","

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

set completeopt+=noinsert

set background=dark
colorscheme molokai

"autocmd BufWritePost *.py call yapf#YAPF()

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
nnoremap <Leader>e :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>a :Tags<CR>
" Task lists
map <leader>tt <Plug>TaskList

" Neoterm
nnoremap <leader>tb :T make<CR>
nnoremap <leader>tc :Tclose<CR>
nnoremap <leader>to :Topen<CR>

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

" Git
noremap <leader>gst :Gstatus<CR>
noremap <leader>gc :Gcommit<CR>

" Java
noremap <leader>i :JavaImport<CR>
" }}}
