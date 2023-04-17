-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-smart-history.nvim',
    'kkharji/sqlite.lua',
    -- 'nvim-lua/popup.nvim',
  },
  keys = {
    { '<C-f>', '<cmd>Telescope live_grep<cr>' },
    { '<C-s>', nil }, -- defined in config
    { '<C-b>', nil }, -- defined in config
    { '<A-s>', '<cmd>Telescope lsp_document_symbols<cr>' },
    { '<A-w>', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
  },
}

P.config = function()
  local map = vim.keymap.set
  local actions = require('telescope.actions')
  local builtin = require('telescope.builtin')

  require('telescope').setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
      },
      mappings = {
        i = {
          ['<c-x>'] = actions.delete_buffer,
          ['<c-s>'] = actions.select_horizontal,
          ['<esc>'] = actions.close, -- <Esc> quit in insert mode
          ['<C-Down>'] = actions.cycle_history_next,
          ['<C-Up>'] = actions.cycle_history_prev,
        },
      },
      prompt_prefix = '→ ',
      selection_caret = '❱ ',
      multi_icon = '❯ ',
      borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
      history = {
        path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
        limit = 100,
      },
    },
  })
  require('telescope').load_extension('smart_history')

  local dropdown_theme = require('telescope.themes').get_dropdown({
    layout_config = { width = { 0.8, max = 80 }, height = 15 },
    prompt = ' ',
    previewer = false,
    prompt_title = '',
    border = true,
    borderchars = {
      prompt = { '━', '┃', ' ', '┃', '┏', '┓', '┛', '┗' },
      results = { '━', '┃', '━', '┃', '┣', '┫', '┛', '┗' },
      preview = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
    },
  })

  map('', '<C-s>', function()
    return builtin.find_files({ find_command = { 'fd', '-t', 'f' } })
  end)
  map('', '<C-b>', function()
    builtin.buffers(dropdown_theme)
  end)
end

return P
