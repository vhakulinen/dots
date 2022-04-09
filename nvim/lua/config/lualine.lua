require('lualine').setup {
  options = {
    theme = 'nord'
  }
}

-- FIXME(ville): If this is in options.lua, lualine will override this.
vim.opt.laststatus = 3
