-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'lewis6991/gitsigns.nvim',
}

P.opts = {
  signs = {
    add = { hl = 'GitAddSign', text = '┃' },
    change = { hl = 'GitChangeSign', text = '┃' },
    delete = { hl = 'GitDeleteSign', text = '▶' },
    topdelete = { hl = 'GitDeleteSign', text = '▶' },
    changedelete = { hl = 'GitChangeDeleteSign', text = '┃' },
    untracked = { hl = 'GitAddSign', text = '╏' },
  },
  numhl = false,
  linehl = false,
  current_line_blame_formatter = '<author>, <author_time:%d-%m-%Y> - <summary>',
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local opts = { buffer = bufnr }
    vim.keymap.set('n', '<A-g>', require('tools.git_menu').open, opts)
    vim.keymap.set('n', '<leader>n', gs.next_hunk, opts)
    vim.keymap.set('n', '<leader>N', gs.prev_hunk, opts)
  end,
  preview_config = { border = { '', '', '', ' ', '', '', '', ' ' } },
}

return P
