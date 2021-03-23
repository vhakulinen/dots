" {{{ Plug
call plug#begin()

" I know there is something to do...
"Plug 'vim-scripts/TaskList.vim'

" Nice indent line
Plug 'Yggdroot/indentLine'

" Gimme bar, be fancy
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Comment blocks of code
Plug 'scrooloose/nerdcommenter'

" Let there be search.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'

" Async make and linting!
"Plug 'benekastah/neomake'

" I want to see some tags
"Plug 'majutsushi/tagbar'

" Change surrounding stuff
Plug 'tpope/vim-surround'

" Git it
Plug 'tpope/vim-fugitive'

" More Go related stuff
Plug 'fatih/vim-go'

" Rust
Plug 'rust-lang/rust.vim'
"Plug 'racer-rust/vim-racer'

" Nice starting page
Plug 'mhinz/vim-startify'

" Typescript
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'Quramy/tsuquyomi'
" Plug 'clausreinke/typescript-tools.vim'
"Plug 'leafgarland/typescript-vim'

" vim proc is needed one of the typescript plugins
"Plug 'Shougo/vimproc.vim'

" Le' editor config
Plug 'editorconfig/editorconfig-vim'
" Give me automatic pairs please
Plug 'jiangmiao/auto-pairs'

" Color scheme
Plug 'morhetz/gruvbox'
" And even more
"Plug 'flazz/vim-colorschemes'
Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'

" Sorry, I might need nerdtree
"Plug 'scrooloose/nerdtree'

" Language Server
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'cespare/vim-toml'

"Plug 'posva/vim-vue'

"Plug 'vhakulinen/gnvim-lsp'

"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}


"Plug 'terryma/vim-multiple-cursors'

Plug 'neovim/nvim-lsp'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'hashivim/vim-terraform'

"Plug 'ayu-theme/ayu-vim'

call plug#end()
" }}}

" {{{ Plugin stuff 
" Go
let g:go_fmt_command = "goimports"

" FZF
let g:fzf_layout = { 'up' : '20%' }
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


"let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
"let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let $FZF_DEFAULT_OPTS=' --layout=reverse --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = 20
  let width = 120
  let horizontal = float2nr(width / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" Use deoplete.
"let g:deoplete#enable_at_startup = 1

" Airline
let g:airline_powerline_fonts=1

" Neomake
"autocmd! BufWritePost *.go Neomake

let g:go_echo_go_info=0

""let g:rustfmt_autosave = 1
"let g:rustfmt_command = 'cargo +nightly fmt -- '
"let g:rustfmt_fail_silently = 1

" }}}

" {{{ General
let mapleader=","

filetype plugin indent on
syntax enable

set lazyredraw

set laststatus=2
set colorcolumn=80
set number
set title
set wildmenu
set expandtab
set noautowrite
set noautowriteall
set nomousehide
set relativenumber
set backspace=indent,eol,start
set cursorline
set nowrap
set listchars+=precedes:<,extends:>
set inccommand=split

set foldmethod=marker

"set completeopt+=noinsert

"let g:gruvbox_italic=1 " Set before loading gruvbox
"set background=light
"colorscheme Tomorrow

if exists("g:gnvim")

    set background=dark
    let g:nord_italic = 1
    let g:nord_underline = 1
    let g:nord_italic_comments = 1
    let g:nord_cursor_line_number_background = 1
    colorscheme nord

    set guifont=Fira\ Code:h13
    set linespace=4

    "call gnvim#cursor_tooltip#load_style("/home/ville/.config/nvim/nord.tmTheme")
    "CursorTooltipStyle Nord

    " TODO(ville): Check when this is merged: https://github.com/arcticicestudio/nord-vim/pull/253/files
    hi TSError guifg=#bf616a ctermfg=131 guibg=NONE ctermbg=NONE gui=underline cterm=underline
    hi TSPunctDelimiter guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSPunctBracket guifg=#eceff4 ctermfg=255 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSPunctSpecial guifg=#eceff4 ctermfg=255 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstant guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstBuiltin guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstMacro guifg=#8fbcbb ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStringRegex guifg=#a3be8c ctermfg=144 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSString guifg=#a3be8c ctermfg=144 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStringEscape guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSCharacter guifg=#a3be8c ctermfg=144 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSNumber guifg=#b48ead ctermfg=139 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSBoolean guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFloat guifg=#b48ead ctermfg=139 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSAnnotation guifg=#d08770 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSAttribute guifg=#8fbcbb ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSNamespace guifg=#8FBCBB ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFuncBuiltin guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFunction guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSFuncMacro guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSParameter guifg=#e5e9f0 ctermfg=255 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSParameterReference guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSMethod guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSField guifg=#e5e9f0 ctermfg=255 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSProperty guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConstructor guifg=#8fbcbb ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSConditional guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSRepeat guifg=#81a1c1 ctermfg=139 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSLabel guifg=#88c0d0 ctermfg=110 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSKeyword guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSKeywordFunction guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSKeywordOperator guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSOperator guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSException guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSType guifg=#8fbcbb ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTypeBuiltin guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStructure guifg=#8FBCBB ctermfg=201 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSInclude guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSVariable guifg=#e5e9f0 ctermfg=255 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSVariableBuiltin guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSText guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSStrong guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSEmphasis guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSUnderline guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTitle guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSLiteral guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSURI guifg=#D8DEE9 ctermfg=226 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTag guifg=#81a1c1 ctermfg=109 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
    hi TSTagDelimiter guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

    set guicursor+=a:blinkon640
else
    set background=dark
    colorscheme gruvbox
endif

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType html,javascript,javascript.jsx,typescript,typescript.tsx,css,scss,typescriptreact setlocal shiftwidth=2

" Make stuff easier when just chillin'
set mouse=a

" Set wrap for quickfix
augroup quickfix
	autocmd!
	autocmd FileType qf setlocal wrap
augroup END

autocmd FileType vue syntax sync fromstart

" }}}

" {{{ Mappings
" exit from insert mode
imap jj <esc>
imap jk <esc>

nnoremap <silent> <leader>n :noh<CR>

" FZF
" nnoremap <Leader>e :FZF<CR>
nnoremap <silent> <Leader>e :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>a :Tags<CR>
" For git files only
nnoremap <silent> <leader>ge :GFiles<CR>

" Task lists
map <silent> <leader>t <Plug>TaskList

" space to open/close folds
nnoremap <space> za

" This is in muscle memory so might as well go with it
inoremap <C-d> <Del>

nnoremap <silent> <Leader>.t :tabnew<CR>

cnoremap <c-p> <up>
cnoremap <c-n> <down>

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
"noremap <leader>gst :Gstatus<CR>
"noremap <leader>gc :Gcommit<CR>

"autocmd FileType typescript nnoremap <F3> :TsuDefinition<CR>
"autocmd FileType typescript nnoremap <F4> :TsuGoBack<CR>

"autocmd FileType go nnoremap <F3> :GoDef<CR>
"autocmd FileType go nnoremap <F4> :GoDefPop<CR>

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
" }}}

" {{{ Language server

let g:go_code_completion_enabled=0
let g:go_doc_keywordprg_enabled=0

nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

let $LD_LIBRARY_PATH='/home/ville/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib'
let $GO111MODULE='on'

autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype typescript,typescriptreact,javascript,javascriptreact setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype vue setlocal omnifunc=v:lua.vim.lsp.omnifunc

lua << EOF
local lspconfig = require'lspconfig'

-- nvim_lsp.rls.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.tsserver.setup{}
lspconfig.vuels.setup{}

lspconfig.gopls.setup{
  root_dir = lspconfig.util.root_pattern('go.mod');
  log_level = 0;
}

EOF

" }}}

" {{{ Treesitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  -- TODO(ville): Enable once this is working properly.
  --indent = {
  --  enable = true,
  --},
}
EOF

" }}}
