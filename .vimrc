let mapleader=","
set nocompatible


set laststatus=2

set colorcolumn=80

command! Q :q
command! W :w
cmap W! w !sudo tee % >/dev/null
cmap w!! w !sudo tee % >/dev/null

" pathogen
call pathogen#infect()


syntax on

filetype on
filetype plugin indent on
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

" Folding stuff
autocmd BufNewFile,BufRead *.py set foldmethod=indent
autocmd BufNewFile,BufRead *.cpp set foldmethod=syntax
set foldlevel=1000
" Highlight colors for folding
" hi Folded ctermbg=0 ctermfg=4

set background=dark
colorscheme wombat256mod
" let g:airline_theme = 'solarized'


if has("gui_running")
    set guioptions-=m  "menu bar
    set guioptions-=T  "toolbar
    set guioptions-=r  "scrollbar
    set guioptions-=L
    set guioptions-=e
    set guifont=Terminus
    colorscheme solarized
    set background=light
endif

" jedi
" autocmd FileType python setlocal completeopt-=preview
set omnifunc=jedi#complete
" dont autocomplete in '.' (dot)
let g:jedi#popop_on_dot = 0
" au FileType python set omnifunc=pythoncomplete#Complete

" Set super tab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" set completeopt=menuone,longest,preview

" tabnew
nnoremap <Leader>.t :tabnew<CR>
" NerdTree
let g:NERDTreeDirArrows=0
nnoremap <Leader>n :NERDTreeToggle<CR>
" Tagbar
nnoremap <Leader>l :TagbarToggle<CR>
" CommandT
nnoremap <Leader>e :CommandT<CR>
" Task lists
map <leader>t <Plug>TaskList
" Exit from insert mode
imap jj <ESC>

"imap <tab> <c-x><c-o>

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

" Execute .vim_run file or if it doesnt exists
" do filetype specific command
function! FileRun()
    if filereadable(".vim_run")
            :!./.vim_run
    elseif &filetype=="python"
        :!python2.7 %
    endif
endfunction
" And map that function
nnoremap <Leader>p :w<CR>:call FileRun()<CR>

" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>


" jamessan's
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
