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

  -- [[ Windows theme colors override
  local focused_ui = '#01347c'
  local menu = '#041c3e'
  local menu_sel = focused_ui
  local menu_thumb = '#0154c8'

  hl('Normal', p.fg, nil)
  hl('CursorLine', nil, focused_ui)
  hl('MatchParen', nil, '#071b39')
  hl('Pmenu', p.fg, menu)
  hl('PmenuSel', nil, menu_sel)
  hl('PmenuSbar', menu, menu)
  hl('PmenuThumb', menu_thumb, menu_thumb)
  hl('FloatBorder', p.fg, menu)
  -- Windows ]]

  -- highlight group for guicursor
  hl('Cursor', '#111111', cursor, { 'bold' })
  hl('Caret', p.bg, p.cursor, 'bold')

  -- oterm.nvim
  hl('otermWin', '#FFFFFF', '#000e23')
  hl('otermBorder', '#FFFFFF', '#000e23')

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
  li('NvimTreeNormal', 'Fg')
  hl('NvimTreeModifiedFile', '#fde047')
  li('NvimTreeRootFolder', 'Comment')
  li('NvimTreeExecFile', 'Todo')
  li('NvimTreeSpecialFile', 'Keyword')
  li('NvimTreeFolderIcon', 'Comment')
  li('NvimTreeImageFile', 'Fg')
  li('NvimTreeGitIgnored', 'Debug')
  hl('NvimTreeGitNew', '#4ade80')
  hl('NvimTreeGitStaged', '#93c5fd')
  li('NvimTreeGitRenamed', 'NvimTreeGitStaged')
  hl('NvimTreeGitMerge', '#c4b5fd')
  hl('NvimTreeGitDeleted', '#fca5a5')
  li('NvimTreeGitDirty', 'NvimTreeGitDeleted')
  hl('NvimTreeWindowPicker', '#FFFFFF', p.ui_frame_bg, 'bold')
  hl('NvimTreeDiagnosticErrorIcon', p.error_stripe, nil, 'bold')
  li('NvimTreeWinSeparator', 'WinSeparator')
  li('NvimTreeLiveFilterPrefix', 'Todo')
  li('NvimTreeLiveFilterValue', 'Fg')
  li('NvimTreeCutHL', 'ErrorUnderline')
  hl('NvimTreeCopiedHL', nil, nil, { 'underline' }, '#2563eb')

  -- ponton.nvim
  hl('StatusLine', '#f9fafb', focused_ui)
  hl('WinBar', p.ui_frame_fg)
  hl('WinSeparator', focused_ui, focused_ui)
  hl('ColorColumn', nil, '#092b5c')

  -- suit.nvim
  hl('suitPrompt', p.todo, menu, { 'bold', 'italic' })

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
  hl('dmapWin', nil, '#012456')
end

return M
