if has('vim_starting')
    set nocompatible

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shugo/neobundle.vim'

"NeoBundle 'wincent/Command-T'
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
NeoBundle 'embear/vim-localvimrc'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'alfredodeza/pytest.vim'

NeoBundle 'tomasr/molokai'
"NeoBundle 'msmhrt/py3venv.vim'

"NeoBundle 'jmcantrell/vim-virtualenv'
"NeoBundle 'lambdalisue/vim-python-virtualenv'

call neobundle#end()

" let g:airline#extensions#tabline#enabled = 1
let g:localvimrc_ask = 0
autocmd BufWritePost *.py call Flake8()
let g:NERDSpaceDelims=1

let g:localvimrc_sandbox = 0

filetype on
filetype plugin indent on

let mapleader=","


set laststatus=2

set colorcolumn=80

syntax on

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


" automatic bracets
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap { {}<Esc>:let leavechar="}"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap ' ''<Esc>:let leavechar="'"<CR>i
inoremap " ""<Esc>:let leavechar="\""<CR>i

imap <C-j> <Esc>:exec "normal f" . leavechar<Cr>a


set background=dark
colorscheme solarized
" colorscheme wombat256mod
" let g:airline_theme = 'solarized'


if has("gui_running")
    set guioptions=i
    " set guifont=Monaco
    set guifont=Source\ Code\ Pro\ Medium\ 10
    colorscheme molokai
    set background=dark
endif


" tabnew
nnoremap <Leader>.t :tabnew<CR>
" NerdTree
"let g:NERDTreeDirArrows=0
nnoremap <Leader>n :NERDTreeToggle<CR>
" Tagbar
nnoremap <Leader>l :TagbarToggle<CR>
" CommandT
"nnoremap <Leader>e :CommandT<CR>
" CtrlP
nnoremap <Leader>e :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>a :CtrlPBufTagAll<CR>
" Task lists
map <leader>t <Plug>TaskList
" Exit from insert mode
imap jj <ESC>


" Add self as keyword in python files
autocmd BufNewFile,BufRead *.py syn keyword pythonBuiltin self

" Debuggin stuff
function! InsertDebug()
    if &filetype=="python"
        ":call append('.', '^import IPython; IPython.embed()')
        norm oimport IPython; IPython.embed( 
        ") add the closing ')' if not using auto brackets
    endif
endfunction
nnoremap <Leader>D :call InsertDebug()<CR>


" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
