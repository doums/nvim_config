local M = {}

local hl = require('util').hl
local li = require('util').li

-- terminal cursor color
local cursor = '#CA7911'

function M.hl()
  local p = require('dark').p

  local paille = '#fde047'
  local blanc = '#ffffff'
  local noir = '#000000'

  -- override
  hl('FloatBorder', nil, p.menu)
  li('@boolean.lua', 'Constant')

  -- highlight group for guicursor
  hl('Cursor', '#111111', cursor, 'bold')
  hl('iCursor', nil, '#69ff00', 'bold')
  hl('oCursor', nil, '#fdba74', 'bold')
  hl('rCursor', nil, '#ff0050', 'bold')
  hl('Caret', p.bg, p.cursor, 'bold')

  -- blink.cmp
  hl('BlinkCmpSource', p.comment)
  hl('BlinkCmpSignatureHelp', p.debug, nil, 'italic')
  hl('BlinkCmpSignatureHelpBorder', p.debug)
  hl('BlinkCmpSignatureHelpActiveParameter', p.string_special, nil, 'italic')

  -- lsp-signature hint (disabled)
  -- li('lspSignatureHint', 'BlinkCmpSignatureHelpActiveParameter')

  -- oterm.nvim
  hl('otermWin', blanc, _G._pdcfg.terminal_bg)
  hl('otermBorder', blanc, _G._pdcfg.terminal_bg)

  -- leap.nvim
  hl('LeapLabel', '#fdd60a', '#0a0a0a', { 'bold', 'nocombine' })
  hl('LeapMatch', '#fdd60a', nil, { 'underline', 'nocombine' })
  hl('LeapLabelPrimary', noir, paille, { 'bold', 'nocombine' })
  hl('LeapLabelSecondary', noir, '#6366f1', 'nocombine')
  -- hl('LeapBackdrop', '#80807F', nil, 'nocombine')

  -- copilot.lua
  hl('CopilotSuggestion', '#42a595', nil, 'italic')
  li('CopilotAnnotation', 'CopilotSuggestion')

  -- nvim-tree.lua
  li('NvimTreeNormal', 'Fg')
  hl('NvimTreeModifiedIcon', '#fde047')
  li('NvimTreeRootFolder', 'Comment')
  li('NvimTreeExecFile', 'Todo')
  li('NvimTreeSpecialFile', 'Keyword')
  li('NvimTreeFolderIcon', 'Comment')
  li('NvimTreeImageFile', 'Fg')
  li('NvimTreeGitFileIgnoredHL', 'Debug')
  hl('NvimTreeGitFileNewHL', '#4ade80')
  hl('NvimTreeGitFileStagedHL', '#93c5fd')
  li('NvimTreeGitFileRenamedHL', 'NvimTreeGitStaged')
  hl('NvimTreeGitFileMergeHL', '#c4b5fd')
  hl('NvimTreeGitFileDeletedHL', '#fca5a5')
  li('NvimTreeGitFileDirtyHL', 'NvimTreeGitDeleted')
  hl('NvimTreeWindowPicker', blanc, p.ui_frame_bg, 'bold')
  hl('NvimTreeDiagnosticErrorIcon', p.error_stripe, nil, 'bold')
  li('NvimTreeWinSeparator', 'WinSeparator')
  li('NvimTreeLiveFilterPrefix', 'Todo')
  li('NvimTreeLiveFilterValue', 'Fg')
  li('NvimTreeCutHL', 'ErrorUnderline')
  hl('NvimTreeCopiedHL', nil, nil, { 'underline' }, '#2563eb')

  -- oil.nvim
  li('OilDir', 'Function')
  li('OilDirIcon', 'Fg')
  hl('OilCreate', p.ansi_green, nil, { 'bold', 'italic' })
  hl('OilDelete', p.error, nil, { 'bold', 'italic' })
  hl('OilMove', p.warning, nil, { 'bold', 'italic' })
  hl('OilCopy', p.info_effect, nil, { 'bold', 'italic' })
  li('OilChange', 'OilMove')
  li('OilRestore', 'OilCopy')
  hl('OilFloat', p.fg, '#161616')
  hl('OilFloatTitle', p.todo, '#161616', { 'bold', 'italic' })

  -- gitsigns.nvim
  li('GitSignsAdd', 'GitAddSign')
  li('GitSignsChange', 'GitChangeSign')
  li('GitSignsDelete', 'GitDeleteSign')
  li('GitSignsTopdelete', 'GitDeleteSign')
  li('GitSignsChangedelete', 'GitChangeDeleteSign')
  li('GitSignsUntracked', 'GitAddSign')

  -- ponton.nvim
  hl('StatusLine', p.ui_frame_bg, p.ui_frame_bg)
  hl('WinBar', p.ui_frame_fg)
  li('WinSeparator', 'StatusLine')

  -- suit.nvim
  hl('suitPrompt', p.todo, p.menu, { 'bold', 'italic' })

  -- snacks picker
  hl('SnacksPicker', 'Fg')
  hl('SnacksPickerBorder', p.ui_border)
  hl('SnacksPickerMatch', paille, nil, 'bold')
  hl('SnacksPickerSearch', paille, p.search, 'bold')
  hl('SnacksPickerSpinner', p.todo)
  hl('SnacksPickerSelected', paille)
  hl('SnacksPickerPrompt', p.keyword, nil, { 'bold', 'italic' })
  li('SnacksPickerDelim', 'NonText')
  li('SnacksPickerRow', 'Number')
  li('SnacksPickerCol', 'NonText')
  li('SnacksPickerTree', 'NonText')
  hl('SnacksPickerToggle', paille, nil, { bold = false })

  -- qflist & loclist
  li('qfText', 'Fg')
  li('qfLineNr', 'Number')
  li('qfFileName', 'Debug')
  hl('qfTitle', p.fg, p.ui_frame_bg, 'bold')
  hl('QuickFixLine', nil)
  li('qfSeparator1', 'NonText')
  li('qfSeparator2', 'NonText')

  -- monark.nvim
  hl('monarkLeap', paille, nil, 'bold')

  -- dmap.nvim
  hl('dmapWin', nil, _G._pdcfg.terminal_bg)
end

return M
