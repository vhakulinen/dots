vim.lsp.enable({
  'rust_analyzer',
  'ts_ls',
  'gopls',
  'clangd',
  'gdscript',
  'lua_ls',
  'ruff',
})

-- Setup LSP keymaps and config on attach.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('n', 'gD', vim.lsp.buf.declaration, 'go to declaration')
    map('n', 'gd', vim.lsp.buf.definition, 'go to definition')


    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local disableAutoformat = vim.bo[event.buf].filetype == 'c' or vim.bo[event.buf].filetype == 'cpp' or
        vim.bo[event.buf].filetype == 'objc'

    -- Format using lsp
    if not disableAutoformat and client and client.server_capabilities.documentFormattingProvider then
      local format_augroup = vim.api.nvim_create_augroup('my-lsp-buf-format', { clear = false })
      vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = event.buf })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = format_augroup,
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format()
        end
      })
    end

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
