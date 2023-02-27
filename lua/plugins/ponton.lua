-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Config for ponton.nvim

local winbar_bg = '#432717'
local winbarnc_bg = '#42342c'
local line_bg = '#332A25'
local line_fg = '#734c36'
local ponton_cdt = require('ponton.condition')
local main_cdt = {
  ponton_cdt.filetype_not,
  { 'NvimTree', 'TelescopePrompt' },
}
local cdts = {
  main_cdt,
}

require('ponton').setup({
  line = {
    'void',
    'mode',
    'read_only',
    'git_branch',
    'spacer',
    'lsp_spinner',
    'line',
    'sep',
    'column',
    'line_percent',
  },
  winbar = {
    'buffer_name',
    'buffer_changed',
  },
  top_line_exclude = { 'NvimTree', 'TelescopePrompt' },
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
        command = { '▼', { '#BDAE9D', line_bg, 'bold' } },
        shell_ex = { '▶', { '#93896C', line_bg, 'bold' } },
        terminal = { '❯', { '#049B0A', line_bg, 'bold' } },
        prompt = { '▼', { '#BDAE9D', line_bg, 'bold' } },
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
        { '#BDAE9D', winbar_bg, 'bold' },
        { '#BDAE9D', winbarnc_bg, 'bold' },
      },
      padding = { 1, nil },
      conditions = { main_cdt },
    },
    buffer_changed = {
      style = {
        { '#a3f307', winbar_bg, 'bold' },
        { '#a3f307', winbarnc_bg, 'bold' },
      },
      value = '✶',
      padding = { nil, 1 },
      placeholder = ' ',
      min_width = 2,
      conditions = cdts,
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
      style = { '#C5656B', line_bg },
      padding = { 1, 1 },
      prefix = ' ',
    },
    lsp_spinner = {
      style = { '#C5656B', line_bg },
      fn = require('lsp_spinner').status,
      padding = { 2, 1 },
      prefix = '󰣪 ',
    },
  },
})
