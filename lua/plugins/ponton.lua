-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'doums/ponton.nvim',
  priority = 999,
  dev = true,
}

P.config = function()
  local p = require('dark').p
  local fg = p.fg
  local fg_nc = '#97999e'
  local winbar_bg = p.ui_frame_bg
  local focused_hl = '#3574f0'
  local line_bg = p.ui_frame_bg
  local line_fg = p.ui_frame_fg
  local ponton_cdt = require('ponton.condition')
  local main_cdt = {
    ponton_cdt.filetype_not,
    { 'NvimTree', 'TelescopePrompt' },
  }

  require('ponton').setup({
    line = {
      'void',
      'mode',
      'read_only',
      'git_branch',
      'spacer',
      'lsp_wip',
      'line',
      'sep',
      'column',
      'line_percent',
    },
    winbar = {
      'buffer_name',
      'buffer_changed',
    },
    segments = {
      mode = {
        map = {
          normal = { ' ' },
          insert = { '❱', { '#69ff00', line_bg, 'bold' } },
          replace = { '❰', { '#ff0050', line_bg, 'bold' } },
          visual = { '◆', { '#43A8ED', line_bg, 'bold' } },
          v_line = { '━', { '#43A8ED', line_bg, 'bold' } },
          v_block = { '■', { '#43A8ED', line_bg, 'bold' } },
          select = { '■', { '#3592C4', line_bg, 'bold' } },
          command = { '▼', { fg, line_bg, 'bold' } },
          shell_ex = { '▶', { '#93896C', line_bg, 'bold' } },
          terminal = { '❯', { '#049B0A', line_bg, 'bold' } },
          prompt = { '▼', { fg, line_bg, 'bold' } },
          inactive = { ' ' },
        },
        margin = { 1, 1 },
      },
      void = {
        length = '20%',
      },
      buffer_name = {
        empty = '-',
        style = {
          { fg, winbar_bg, { 'bold', 'underline' }, focused_hl },
          { fg_nc, winbar_bg, 'bold' },
        },
        padding = { 1, 1 },
        conditions = { main_cdt },
      },
      buffer_changed = {
        style = {
          { '#fde047', winbar_bg, 'underline', focused_hl },
          { '#fde047', winbar_bg },
        },
        value = '󰷉',
        padding = { nil, 1 },
        placeholder = '',
        min_width = 0,
        conditions = {
          main_cdt,
          ponton_cdt.is_normal_buf,
        },
      },
      read_only = {
        style = { '#C75450', line_bg, 'bold' },
        value = '',
        padding = { nil, 1 },
        conditions = {
          ponton_cdt.is_read_only,
          ponton_cdt.is_normal_buf,
        },
      },
      spacer = {},
      sep = {
        style = { line_fg, line_bg },
        text = '⏽',
      },
      line_percent = {
        style = { line_fg, line_bg },
        padding = { nil, 1 },
      },
      line = {
        style = { line_fg, line_bg },
        padding = { 1 },
      },
      column = {
        style = { line_fg, line_bg },
        left_adjusted = true,
        padding = { nil, 1 },
      },
      git_branch = {
        style = { line_fg, line_bg },
        padding = { 1, 1 },
        prefix = ' ',
      },
      lsp_wip = {
        style = { line_fg, line_bg },
        fn = require('lswip').get,
        padding = { 1, 1 },
      },
    },
  })
end

return P
