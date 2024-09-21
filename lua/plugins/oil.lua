-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'stevearc/oil.nvim',
}

P.config = function()
  local detailed = false
  local type_column = {
    'type',
    highlight = 'NonText',
    icons = {
      directory = '󰉋',
      file = '≡',
      link = '⟷',
      char = '⍆',
      block = '∎',
      socket = '⍆',
      fifo = '⥊',
      add_padding = false,
    },
  }
  local columns_detailed = {
    { 'permissions', highlight = 'Todo' },
    { 'size', highlight = 'Number' },
    type_column,
  }

  require('oil').setup({
    default_file_explorer = true,
    delete_to_trash = true,
    columns = {
      type_column,
    },
    keymaps = {
      ['?'] = 'actions.show_help',
      ['<C-s>'] = {
        'actions.select',
        opts = { horizontal = true },
        desc = 'Open the entry in a vertical split',
      },
      ['<C-v>'] = {
        'actions.select',
        opts = { vertical = true },
        desc = 'Open the entry in a horizontal split',
      },
      ['<C-t>'] = {
        'actions.select',
        opts = { tab = true },
        desc = 'Open the entry in new tab',
      },
      ['<M-r>'] = 'actions.refresh',
      ['<C-l>'] = 'actions.select',
      ['<C-h>'] = 'actions.parent',
      ['go'] = 'actions.open_external',
      ['H'] = 'actions.toggle_hidden',
      ['<C-d>'] = function()
        detailed = not detailed
        require('oil').set_columns(
          detailed and columns_detailed or { type_column }
        )
      end,
    },
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      number = false,
      relativenumber = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      -- set conceallevel to 0 to avoid concealed text flickers when using leap
      -- see https://github.com/ggandor/leap.nvim/issues/1
      -- https://github.com/stevearc/oil.nvim/issues/333
      conceallevel = 0,
      concealcursor = 'nvic',
    },
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 66,
      max_height = 20,
      border = { ' ', ' ', ' ', ' ', '', '', '', ' ' },
      win_options = {
        winblend = 0,
        colorcolumn = '',
        winhighlight = 'NormalFloat:OilFloat,FloatBorder:OilFloat,FloatTitle:OilFloatTitle',
      },
    },
    preview = {
      max_width = { 66, 0.8 },
      min_width = { 20, 0.1 },
      max_height = 20,
      min_height = { 5, 0.1 },
      border = { '', '', '', ' ', '', '', '', ' ' },
      win_options = {
        winblend = 0,
        colorcolumn = '',
        winhighlight = 'NormalFloat:OilFloat,FloatBorder:OilFloat',
      },
    },
    progress = {
      border = false,
    },
    keymaps_help = {
      border = false,
    },
  })

  vim.keymap.set('n', '<M-o>', function()
    require('oil').toggle_float()
  end)
end

return P
