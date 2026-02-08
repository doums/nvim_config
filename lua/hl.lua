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
  local ombre = '#2c2d2f'

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
  hl('NvimTreeHiddenDisplay', p.todo, nil, { 'bold' })
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
  hl('OilFloat', p.fg)
  hl('OilFloatTitle', p.todo, nil, { 'bold', 'italic' })
  hl('OilFloatBorder', ombre)

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

  -- snacks prompt
  hl('SnacksInputNormal', p.fg, p.menu)
  hl('SnacksInputTitle', p.todo, p.menu, { 'bold', 'italic' })
  hl('SnacksInputBorder', p.menu, p.menu)
  hl('SnacksInputIcon', p.todo, p.menu, 'bold')
  hl('SnacksInputIcon', p.todo, p.menu, 'bold')

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

  -- dap
  -- hl('DapBreakpoint', '#db5c5c')
  hl('DapBreakpoint', '#84db31')
  li('DapBreakpointCondition', 'DapBreakpoint')
  li('DapLogPoint', 'Function')
  hl('DapStoppedPoint', '#fde047')
  hl('DapBreakpointLine', nil, '#40252b')
  hl('DapStoppedLine', nil, '#2A5091')
  li('DapBreakpointRejected', 'DapBreakpoint')
  -- dap-ui
  hl('DapUINormal', p.debug)
  li('DapUINormalNC', 'DapUINormal')
  hl('DapUIFloatNormal', p.fg)
  hl('DapUIFloatBorder', ombre)
  hl('DapUIDecoration', p.comment)
  li('DapUIVariable', 'PreProc')
  hl('DapUIType', p.inline_hint)
  hl('DapUIFrameName', p.fn)
  hl('DapUIScope', p.constant, nil, 'bold')
  li('DapUISource', 'String')
  li('DapUIValue', 'Number')
  hl('DapUIModifiedValue', '#B2AE60')
  hl('DapUIUnavailable', p.comment)
  li('DapUIUnavailableNC', 'DapUIUnavailable')
  hl('DapUIPlayPause', '#22c55e')
  li('DapUIPlayPauseNC', 'DapUIPlayPause')
  li('DapUIRestart', 'DapUIPlayPause')
  li('DapUIRestartNC', 'DapUIPlayPauseNC')
  hl('DapUIStop', '#cb5858')
  li('DapUIStopNC', 'DapUIStop')
  hl('DapUIStepInto', '#a8acb0')
  li('DapUIStepIntoNC', 'DapUIStepInto')
  li('DapUIStepOver', 'DapUIStepInto')
  li('DapUIStepOverNC', 'DapUIStepInto')
  li('DapUIStepOut', 'DapUIStepInto')
  li('DapUIStepOutNC', 'DapUIStepInto')
  li('DapUIStepBack', 'DapUIStepInto')
  li('DapUIStepBackNC', 'DapUIStepInto')
end

return M
