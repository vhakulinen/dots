--
-- Some of these are sourced from kickstart.nvim: https://github.com/nvim-lua/kickstart.nvim
--

require'options'
require'keymaps'

-- Install lazy.nvim, if needed.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Web icons.
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { -- Colorscheme
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd[[colorscheme tokyonight]]
    end
  },

  -- Change surrounding characters.
  'tpope/vim-surround',

  -- Git.
  'tpope/vim-fugitive',

  -- Nice starting page.
  'mhinz/vim-startify',

  -- Automatic pairs.
  'jiangmiao/auto-pairs',

  { -- Progress messages.
    'j-hui/fidget.nvim',
    tag = 'v1.4.1', -- NOTE(ville): No stable branch available
    opts = { },
  },

  { -- Treesitter.
    'nvim-treesitter/nvim-treesitter',
    opts = { }
  },

  { -- Rust.
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
      -- Force the edition. If its missing from rustfmt.toml, it will default to 2015.
      --vim.g.rustfmt_options = '--edition 2021'
    end
  },

  { -- Which key.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      plugins = {
        registers = false,
      },
      window = {
        position = 'top'
      }
    }
  },

  { -- Telescope
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local actions = require'telescope.actions'
      local builtin = require'telescope.builtin'
      local ts = require'telescope'

      ts.setup{
        defaults = {
          mappings = {
            i = {
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,
              ['<esc>'] = actions.close
            }
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      ts.load_extension'ui-select'

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { desc = 'Telescope: ' .. desc })
      end

      map('<leader>se', builtin.find_files, 'search files')
      map('<leader>sf', builtin.find_files, 'search files')
      map('<leader>sb', builtin.buffers, 'search buffers')
      map('<leader>sg', builtin.live_grep, 'search by grep')
      map('<leader>sw', builtin.grep_string, 'search string under cursor')
      map('<leader>sd', builtin.diagnostics, 'search diagnostics')
    end
  },

  { -- LSP
    'neovim/nvim-lspconfig',
    config = function()
      -- Setup LSP keymaps and config on attach.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('n', 'gD', vim.lsp.buf.declaration, 'go to declaration')
          map('n', 'gd', vim.lsp.buf.definition, 'go to definition')
          map('n', 'gi', vim.lsp.buf.implementation, 'go to implementation')

          map('n', 'K', vim.lsp.buf.hover, 'open hover documentation')
          map('n', '<C-k>', vim.lsp.buf.signature_help, 'show signature help')
          map('i', '<C-k>', vim.lsp.buf.signature_help, 'show signature help')

          map('n', '<leader>D', vim.lsp.buf.type_definition, 'go to type definition')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'rename all references')
          map('n', '<leader>rf', vim.lsp.buf.references, 'list all references')
          map('n', '<leader>ca', vim.lsp.buf.code_action, 'show code actions')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Format using lsp
          if client and client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my-lsp-buf-format', { clear = true }),
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format()
              end
            })
          end

          -- Disable semantic highlighting from LSP.
          -- Remove once https://github.com/shaunsingh/nord.nvim/issues/134 is fixed.
          --client.server_capabilities.semanticTokensProvider = nil

          -- Highlight (and clear highlight) references of the word under cursor.
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('my-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('my-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'my-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            -- Enable inlay hints by default.
            vim.lsp.inlay_hint.enable(true)

            -- Toggle inlay hints.
            map('n', '<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, 'toggle inlay hints')
          end
        end
      })

      -- Plugins use extend the nvim's default capabilities. We need to take
      -- use of those manually.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local lspconfig = require'lspconfig'
      lspconfig.rust_analyzer.setup{
        capabilities = capabilities,
      }
      lspconfig.tsserver.setup{
        capabilities = capabilities,
      }
      lspconfig.gopls.setup{
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('go.mod'),
        log_level = 0,
      }
      lspconfig.gdscript.setup{
        capabilities = capabilities,
      }
    end
  },

  { -- Autocomplection
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Sources
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require'cmp'
      local luasnip = require'luasnip'

      cmp.setup({
        mapping = {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          ['<C-e>'] = cmp.mapping.close(),

          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.confirm({ select = true }),

          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer', keyword_length = 3 },
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        view = {
          entries = 'native'
        }
      })
    end
  },
}

require('lazy').setup(plugins, {
  performance = {
    rtp = {
      paths = {
        -- Keep the gnvim rtp path.
        vim.g.gnvim_rtp_path,
      }
    }
  }
})
