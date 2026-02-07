local P = {
  'stevearc/oil.nvim',
  lazy = false,
}

P.config = function()
  local detailed = false
  local float_style =
    'NormalFloat:OilFloat,FloatBorder:OilFloatBorder,FloatTitle:OilFloatTitle'
  local type_column = {
    'type',
    highlight = 'NonText',
    icons = {
      directory = '󰉋',
      file = '󰧮',
      link = '󰌷',
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
      max_width = 66,
      max_height = 20,
      border = 'bold',
      win_options = {
        winblend = 0,
        colorcolumn = '',
        winhighlight = float_style,
      },
    },
    preview_win = {
      max_width = { 66, 0.8 },
      min_width = { 20, 0.1 },
      max_height = 20,
      min_height = { 5, 0.1 },
      border = 'bold',
      win_options = {
        pagging = 0,
        winblend = 0,
        colorcolumn = '',
        winhighlight = float_style,
      },
    },
    confirmation = {
      border = 'bold',
      max_width = { 66, 0.9 },
      min_width = { 20, 0.1 },
      win_options = {
        winhighlight = float_style,
        -- if wrapping it breaks the display!
        wrap = false,
      },
    },
    progress = {
      border = 'bold',
      win_options = {
        winhighlight = float_style,
      },
    },
    keymaps_help = {
      -- this is the only supported option!
      border = false,
    },
  })

  vim.keymap.set('n', '<M-o>', function()
    require('oil').toggle_float()
  end)
end

return P
