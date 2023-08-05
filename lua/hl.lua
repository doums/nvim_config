-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local hl = require('utils').hl
local li = require('utils').li

function M.hl()
  local p = require('cooper').p

  -- highlight group for guicursor
  hl('Caret', p.bg, p.cursor, 'bold')

  -- oterm.nvim
  hl('otermWin', '#FFFFFF', '#1C1C1C')
  hl('otermBorder', '#FFFFFF', '#1C1C1C')

  -- leap.nvim
  local reverse_fg = _G.terminal_bg
  local leap_cursor = '#E4F7FF'
  hl('LeapMatch', '#F49810', nil, { 'underline', 'nocombine' })
  hl('LeapLabelPrimary', reverse_fg, '#F49810', 'nocombine')
  hl('LeapLabelSecondary', reverse_fg, '#8C5845', 'nocombine')
  hl('LeapLabelSelected', '#DDDDFF', nil, { 'bold', 'nocombine' })
  -- hl('LeapBackdrop', '#80807F', nil, 'nocombine')
  -- leap use Cursor hl group, customize it
  hl('Cursor', reverse_fg, leap_cursor, { 'nocombine', 'bold' })

  -- nvim-cmp
  li('CmpItemMenu', 'Fg')
  li('CmpItemAbbr', 'Fg')
  li('CmpItemKind', 'Fg')
  hl('CmpItemAbbrDeprecated', nil, nil, { 'strikethrough' })
  hl('CmpItemAbbrMatch', p.menu_hl, nil, 'bold')
  li('CmpItemAbbrMatchFuzzy', 'CmpItemAbbrMatch')

  -- nvim-tree.lua
  li('NvimTreeRootFolder', 'Comment')
  li('NvimTreeExecFile', 'Todo')
  li('NvimTreeSpecialFile', 'Function')
  li('NvimTreeFolderIcon', 'Constant')
  li('NvimTreeImageFile', 'Normal')
  li('NvimTreeGitIgnored', 'Debug')
  hl('NvimTreeGitNew', '#42905B')
  hl('NvimTreeGitStaged', '#39C064')
  hl('NvimTreeGitRenamed', '#507EAE')
  hl('NvimTreeGitDeleted', '#BD5B5B')
  li('NvimTreeGitDirty', 'NvimTreeGitDeleted')
  hl('NvimTreeWindowPicker', '#FFFFFF', p.ui_frame_bg, 'bold')
  hl('NvimTreeLspDiagnosticsError', p.error_stripe, nil, 'bold')
  li('NvimTreeWinSeparator', 'WinSeparator')
  li('NvimTreeLiveFilterPrefix', 'CurSearch')
  li('NvimTreeLiveFilterValue', 'Search')

  -- ponton.nvim
  hl('StatusLine', p.ui_frame_bg, p.ui_frame_bg)
  hl('WinBar', p.ui_frame_fg)
  li('WinSeparator', 'StatusLine')

  -- suit.nvim
  hl('suitPrompt', p.todo, p.menu, { 'bold', 'italic' })

  -- telescope.nvim
  li('TelescopeNormal', 'Fg')
  li('TelescopeSelection', 'Visual')

  -- lsp_signature.nvim
  hl('codeHint', p.code_lens, nil, 'italic')
  hl('inlayHint', '#604417', nil, 'italic')

  -- qflist & loclist
  li('qfLineNr', 'Number')
  li('qfFileName', 'Debug')
  hl('qfTitle', p.fg, p.ui_frame_bg, 'bold')
  hl('QuickFixLine', nil)

  -- monark.nvim
  hl('monarkLeap', leap_cursor, nil, 'bold')
end

return M
