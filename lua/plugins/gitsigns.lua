-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'lewis6991/gitsigns.nvim',
}

P.opts = {
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '▶' },
    topdelete = { text = '▶' },
    changedelete = { text = '┃' },
    untracked = { text = '╏' },
  },
  signs_staged_enable = false,
  numhl = false,
  linehl = false,
  current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>',
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<A-g>', require('tools.git_menu').open, opts)
    vim.keymap.set('n', '<leader>n', function()
      gs.nav_hunk('next')
    end, opts)
    vim.keymap.set('n', '<leader>N', function()
      gs.nav_hunk('prev')
    end, opts)
  end,
  preview_config = { border = _G._pdcfg.win_border },
}

return P
