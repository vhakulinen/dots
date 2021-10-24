" {{{ Plug
call plug#begin()

" Nice indent line
Plug 'Yggdroot/indentLine'

" Gimme bar, be fancy
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Comment blocks of code
Plug 'scrooloose/nerdcommenter'

" Change surrounding stuff
Plug 'tpope/vim-surround'
" Git
Plug 'tpope/vim-fugitive'

" More Go related stuff
Plug 'fatih/vim-go'

" Rust
"Plug 'rust-lang/rust.vim'

" Nice starting page
Plug 'mhinz/vim-startify'

" Le' editor config
Plug 'editorconfig/editorconfig-vim'
" Automatic pairs please
Plug 'jiangmiao/auto-pairs'

" Color scheme
Plug 'tomasr/molokai'
Plug 'arcticicestudio/nord-vim'

Plug 'cespare/vim-toml'

" Code completion and lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()
" }}}

" {{{ Plugin stuff 
" Go
let g:go_fmt_command = "goimports"
let g:go_echo_go_info=0

" Airline
let g:airline_powerline_fonts=1

" Telescope
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  }
}
EOF

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
set mouse=a

set completeopt=menu,menuone,noselect

if exists("g:gnvim")
    set background=dark
    let g:nord_italic = 1
    let g:nord_underline = 1
    let g:nord_italic_comments = 1
    let g:nord_cursor_line_number_background = 1
    colorscheme nord

    set guifont=Fira\ Code:h13
    set linespace=4
    set guicursor+=a:blinkon640
else
    set background=dark
    colorscheme gruvbox
endif

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType html,javascript,javascript.jsx,typescript,typescript.tsx,css,scss,typescriptreact setlocal shiftwidth=2

" Set wrap for quickfix
augroup quickfix
	autocmd!
	autocmd FileType qf setlocal wrap
augroup END

" }}}

" {{{ Mappings
" exit from insert mode
imap jj <esc>
imap jk <esc>

nnoremap <silent> <leader>n :noh<CR>

" FZF
" nnoremap <Leader>e :FZF<CR>
nnoremap <silent> <Leader>e <cmd>Telescope find_files<CR>
nnoremap <silent> <leader>b <cmd>Telescope buffers<CR>

" space to open/close folds
nnoremap <space> za

inoremap <C-d> <Del>
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

" Terminal mode mappings
tmap <c-w> <c-\><c-n><c-w>
tmap <c-w><c-c> <c-\><c-n>
au WinEnter term://* startinsert

" Mappings for tabs.
nnoremap <silent> <Leader>.t :tabnew<CR>
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
inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

let $GO111MODULE='on'

lua <<EOF
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local luasnip = require("luasnip")
  cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = "luasnip" },
      { name = 'buffer', keyword_length = 5 },
    }),
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    experimental = {
      ghost_text = true
    }
  })

  -- Setup lspconfig.
  local lspconfig = require'lspconfig'
  local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )

  lspconfig.rust_analyzer.setup{
    capabilities = capabilities
  }
  lspconfig.tsserver.setup{
    capabilities = capabilities
  }

  lspconfig.gopls.setup{
    capabilities = capabilities;
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
  indent = {
    enable = true,
  },
}
EOF

" }}}
