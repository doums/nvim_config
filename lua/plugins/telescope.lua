-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-smart-history.nvim',
    'kkharji/sqlite.lua',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    -- 'nvim-lua/popup.nvim',
  },
  keys = {
    { '<C-f>', nil }, -- defined in config
    { '<C-M-f>', nil },
    { '<C-s>', nil },
    { '<C-M-s>', nil },
    { '<C-b>', nil },
    { '<A-s>', '<cmd>Telescope lsp_document_symbols<cr>' },
    { '<A-w>', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
  },
}

P.config = function()
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
        '--trim',
      },
      mappings = {
        i = {
          -- navigate the results with C-hjkl
          ['<c-j>'] = 'move_selection_next',
          ['<c-k>'] = 'move_selection_previous',
          ['<c-h>'] = 'results_scrolling_left',
          ['<c-l>'] = 'results_scrolling_right',
          ['<c-s-j>'] = 'results_scrolling_up',
          ['<c-s-k>'] = 'results_scrolling_down',
          -- navigate the preview with A-hjkl
          ['<m-j>'] = 'preview_scrolling_down',
          ['<m-k>'] = 'preview_scrolling_up',
          ['<m-h>'] = 'preview_scrolling_left',
          ['<m-l>'] = 'preview_scrolling_right',
          ['<c-s>'] = 'select_horizontal',
          ['<esc>'] = 'close', -- <Esc> quit in insert mode
          ['<C-Down>'] = 'cycle_history_next',
          ['<C-Up>'] = 'cycle_history_prev',
        },
      },
      prompt_prefix = '> ',
      selection_caret = '  ',
      multi_icon = '❱',
      borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
      history = {
        path = vim.fn.stdpath('data') .. '/db/telescope_history.sqlite3',
        limit = 100,
      },
    },
    pickers = {
      buffers = {
        mappings = {
          i = {
            ['<c-x>'] = 'delete_buffer',
          },
        },
      },
    },
  })

  -- extensions
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('smart_history')

  local dropdown = function(opts)
    opts = opts or {}
    opts = vim.tbl_deep_extend('keep', opts, {
      -- theme ref https://github.com/nvim-telescope/telescope.nvim/blob/0df05c9e9f791dbc542c1fb612195f4dc97209b6/lua/telescope/themes.lua
      -- layout_config = {},
      prompt_title = false,
      preview_title = false,
      borderchars = {
        preview = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
        prompt = { '━', '┃', ' ', '┃', '┏', '┓', '┃', '┃' },
        results = { '━', '┃', '━', '┃', '┣', '┫', '┛', '┗' },
      },
    })
    return require('telescope.themes').get_dropdown(opts)
  end

  vim.keymap.set('', '<C-f>', function()
    builtin.live_grep(dropdown({
      prompt_prefix = 'rg> ',
      disable_coordinates = true,
    }))
  end)
  vim.keymap.set('', '<C-M-f>', function()
    require('tools.search_menu').search({
      cmd = 'rg',
      picker_opts = dropdown({
        disable_coordinates = true,
      }),
    })
  end)
  vim.keymap.set('', '<C-s>', function()
    builtin.find_files(dropdown({
      find_command = { 'fd', '-t', 'f', '--strip-cwd-prefix' },
      prompt_prefix = 'fd> ',
    }))
  end)
  vim.keymap.set('', '<C-M-s>', function()
    require('tools.search_menu').search({ cmd = 'fd', picker_opts = dropdown() })
  end)
  vim.keymap.set('', '<C-b>', function()
    builtin.buffers(dropdown({
      previewer = false,
      borderchars = {
        prompt = { '━', '┃', ' ', '┃', '┏', '┓', '┛', '┗' },
        results = { '━', '┃', '━', '┃', '┣', '┫', '┛', '┗' },
        preview = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
      },
    }))
  end)
end

return P
