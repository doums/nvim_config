-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = { picker = {}, image = { enabled = true } },
}

P.opts.picker = {
  prompt = '> ',
  layouts = {
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#dropdown
    dropdown = {
      layout = {
        backdrop = false,
        row = -4,
        width = 0.4,
        min_width = 76,
        height = 0.8,
        border = 'none',
        box = 'vertical',
        {
          win = 'preview',
          title = nil,
          height = 0.4,
          min_height = 4,
          border = 'bold',
          wo = {
            signcolumn = 'no',
          },
        },
        {
          box = 'vertical',
          border = 'bold',
          title = '{title} {live} {flags}',
          title_pos = 'center',
          {
            win = 'input',
            height = 1,
            -- bottom bold
            border = { '', '', '', '', '', '━', '', '' },
          },
          { win = 'list', border = 'none' },
        },
      },
    },
    nopreview = {
      layout = {
        preview = false,
        backdrop = false,
        row = -8,
        width = 0.4,
        min_width = 66,
        height = 0.6,
        max_height = 20,
        min_height = 6,
        border = 'bold',
        box = 'vertical',
        title = '{title} {live} {flags}',
        title_pos = 'center',
        {
          win = 'input',
          height = 1,
          border = { '', '', '', '', '', '━', '', '' },
        },
        { win = 'list', border = 'none' },
      },
    },
  },
  layout = function(picker)
    if picker == 'buffers' then
      return { preset = 'nopreview' }
    end
    return vim.o.lines >= 20 and 'dropdown'
      or {
        preset = 'dropdown',
        preview = false,
      }
  end,
  toggles = {
    hidden = '󰈈',
    ignored = '󰘓',
    follow = 'f',
    modified = '󰷉',
    regex = { icon = '󰑑', value = false },
  },
  formatters = {
    file = { git_status_hl = false },
    selected = { unselected = false },
  },
  ui_select = false,
  win = {
    -- input window
    input = {
      keys = {
        ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
        ['<A-BS>'] = {
          '<c-s-w>',
          mode = { 'i' },
          expr = true,
          desc = 'delete word',
        },
        ['<a-k>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
        ['<a-j>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
        ['<s-Left>'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
        ['<s-Right>'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
        ['<c-s-k>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
        ['<c-s-j>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
        ['<a-CR>'] = { 'focus_list', mode = { 'i', 'n' } },
        -- alt+shift+,
        ['<s->>'] = { 'toggle_help_input', mode = { 'i', 'n' } },
      },
    },
    list = {
      keys = {
        ['<c-k>'] = 'list_scroll_up',
        ['<c-j>'] = 'list_scroll_down',
      },
    },
  },
  icons = {
    files = {
      enabled = true,
    },
    ui = {
      live = '󰐰 ',
      hidden = '󰈈',
      ignored = '󰘓',
      follow = 'f',
      selected = '❱ ',
      unselected = nil,
    },
    git = {
      enabled = true,
    },
    diagnostics = {
      Error = '✗ ',
      Warn = '⚠ ',
      Info = 'i ',
      Hint = '~ ',
    },
  },
}

P.keys = {
  {
    '<C-s>',
    function()
      Snacks.picker.files({ cmd = 'fd' })
    end,
    desc = 'Find Files',
  },
  {
    '<C-A-s>',
    function()
      require('tools.search_menu').search({ cmd = 'fd' })
    end,
    desc = 'fd',
  },
  {
    '<C-f>',
    function()
      Snacks.picker.grep({ cmd = 'rg' })
    end,
    desc = 'Grep',
  },
  {
    '<C-A-f>',
    function()
      require('tools.search_menu').search({ cmd = 'rg' })
    end,
    desc = 'rg',
  },
  {
    '<C-b>',
    function()
      Snacks.picker.buffers()
    end,
    desc = 'Buffers',
  },
  {
    '<A-s>',
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = 'LSP Symbols',
  },
  {
    '<A-S-w>',
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = 'LSP Workspace Symbols',
  },
  {
    '<leader>gs',
    function()
      Snacks.picker.git_status()
    end,
    desc = 'Git Status',
  },
  {
    '<leader>gd',
    function()
      Snacks.picker.git_diff()
    end,
    desc = 'Git Diff (Hunks)',
  },
}

return P
