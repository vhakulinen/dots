function get_config(name)
    return string.format("require(\"config/%s\")", name)
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Nice indent line
  use 'Yggdroot/indentLine'

  -- Comment blocks of code
  use 'scrooloose/nerdcommenter'

  -- Channge surrounding characters
  use 'tpope/vim-surround'
  -- Git
  use 'tpope/vim-fugitive'

  -- Go stuff
  -- use 'fatih/vim-go'

  -- Rust
  use {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = get_config('rust')
  }

  -- Nice starting page
  use 'mhinz/vim-startify'

  -- editor config
  use 'editorconfig/editorconfig-vim'
  -- Automatic pairs please
  use 'jiangmiao/auto-pairs'

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', 'shaunsingh/nord.nvim' },
    config = get_config('lualine')
  }

  -- Colorshcme
  use {
    'shaunsingh/nord.nvim',
    config = get_config('nord'),
  }

  -- Toml
  use { 'cespare/vim-toml', ft = 'toml' }

  -- Code completion and lsp
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'neovim/nvim-lspconfig',
    },
    config = get_config('nvim-cmp')
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { 'kyazdani42/nvim-web-devicons' },
    run = ':TSUpdate'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = get_config("telescope")
  }
end)
