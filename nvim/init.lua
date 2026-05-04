vim.pack.add({
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

vim.cmd [[colorscheme tokyonight]]

require('mini.icons').setup()
require('mini.pick').setup({
  mappings = {
    -- refine = '<Space>'
  },
  window = {
    config = function()
      -- Centeted on screen.
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
  }
})
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.snippets').setup()
require('mini.completion').setup()
require('mini.notify').setup()

vim.ui.select = MiniPick.ui_select

require('lazydev').setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
