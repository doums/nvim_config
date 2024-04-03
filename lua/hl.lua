-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local hl = require('utils').hl
local li = require('utils').li

-- terminal cursor color
local cursor = '#CA7911'

function M.hl()
  local p = require('dark').p

  -- highlight group for guicursor
  hl('Cursor', '#111111', cursor, { 'bold' })
  hl('Caret', p.bg, p.cursor, 'bold')

  -- oterm.nvim
  hl('otermWin', '#FFFFFF', '#1C1C1C')
  hl('otermBorder', '#FFFFFF', '#1C1C1C')

  -- leap.nvim
  local leap_primary = '#fde047'
  hl('LeapMatch', '#F49810', nil, { 'underline', 'nocombine' })
  hl('LeapLabelPrimary', '#000000', leap_primary, { 'bold', 'nocombine' })
  hl('LeapLabelSecondary', '#000000', '#6366f1', 'nocombine')
  -- hl('LeapBackdrop', '#80807F', nil, 'nocombine')

  -- copilot.lua
  hl('CopilotSuggestion', '#42a595', nil, 'italic')
  li('CopilotAnnotation', 'CopilotSuggestion')

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
  li('NvimTreeSpecialFile', 'Keyword')
  li('NvimTreeFolderIcon', 'Comment')
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

  -- qflist & loclist
  li('qfLineNr', 'Number')
  li('qfFileName', 'Debug')
  hl('qfTitle', p.fg, p.ui_frame_bg, 'bold')
  hl('QuickFixLine', nil)

  -- monark.nvim
  hl('monarkLeap', leap_primary, nil, 'bold')

  -- dmap.nvim
  hl('dmapWin', nil, _G.terminal_bg)
end

return M
