" {{{ NeoBundle 
if has('vim_starting')
    set nocompatible

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shugo/neobundle.vim'

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vim-scripts/TaskList.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'alfredodeza/pytest.vim'
NeoBundle 'whatyouhide/vim-gotham'
NeoBundle 'fatih/vim-go'
NeoBundle 'tomasr/molokai'

call neobundle#end()
" }}}

" {{{ General stuff
let mapleader=","

filetype on
filetype plugin indent on
syntax on

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

" }}}

" {{{ Plugin stuff 

" You complete me
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_keep_logfiles = 1
" NERD
let g:NERDSpaceDelims=1
" Go
let g:go_fmt_command = "goimports"
" Airline
let g:airline_powerline_fonts = 1

" Dunno if this really is needed...
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

" }}}

" {{{ Language spcific stuff
" Python
autocmd BufWritePost *.py call Flake8()
" Add self as keyword in python files
autocmd BufNewFile,BufRead *.py syn keyword pythonBuiltin self

" }}}

" {{{ Mappings
" automatic bracets
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap { {}<Esc>:let leavechar="}"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap ' ''<Esc>:let leavechar="'"<CR>i
inoremap " ""<Esc>:let leavechar="\""<CR>i
imap <C-j> <Esc>:exec "normal f" . leavechar<Cr>a

inoremap <C-d> <Del>

nnoremap <space> za

" tabnew
nnoremap <Leader>.t :tabnew<CR>
" NerdTree
"let g:NERDTreeDirArrows=0
nnoremap <Leader>n :NERDTreeToggle<CR>
" Tagbar
nnoremap <Leader>l :TagbarToggle<CR>
" CtrlP
nnoremap <Leader>e :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>a :CtrlPBufTagAll<CR>
" Task lists
map <leader>t <Plug>TaskList
" Exit from insert mode
imap jj <ESC>

" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
" }}}

" {{{ GUI
if has("gui_running")
    set guioptions=i
    " set guifont=Monaco
    set guifont=Source\ Code\ Pro\ Medium\ 10
    colorscheme molokai
    set background=dark
endif
" }}}

" {{{ Custom functionality (includes some mappigs)
" Debuggin stuff
function! InsertDebug()
    if &filetype=="python"
        ":call append('.', '^import IPython; IPython.embed()')
        norm oimport IPython; IPython.embed( 
        ") add the closing ')' if not using auto brackets
    endif
endfunction
nnoremap <Leader>D :call InsertDebug()<CR>

function! Run()
    if &filetype=="go"
        :GoRun
    endif
endfunction
nnoremap <leader>p :call Run()<CR>
" }}}"
