-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local hl = require('utils').hl
local li = require('utils').li

-- after loading a colorscheme, re-generate hl groups
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    M.hl()
    vim.notify(
      'hl groups have been generated ✓',
      vim.log.levels.INFO,
      { title = 'nvim-config' }
    )
  end,
})

function M.hl()
  -- highlight group for guicursor
  hl('Caret', '#2A211C', '#889AFF', 'bold')
  hl('WinSeparator', '#332a25', '#332a25')

  -- oterm.nvim
  hl('otermWin', '#FFFFFF', '#212121')
  hl('otermBorder', '#FFFFFF', '#212121')

  -- leap.nvim
  hl('LeapMatch', '#aa4e00', nil, { 'underline', 'nocombine' })
  hl('LeapLabelPrimary', '#212121', '#f49810', 'nocombine')
  hl('LeapLabelSecondary', '#212121', '#8c5845', 'nocombine')
  hl('LeapLabelSelected', '#ddddff', nil, { 'bold', 'nocombine' })
  -- hl('LeapBackdrop', '#80807f', nil, 'nocombine')
  -- leap use Cursor hl group, customize it
  hl('Cursor', '#212121', '#df4a00', { 'nocombine', 'bold' })

  -- nvim-cmp
  li('CmpItemMenu', 'Fg')
  li('CmpItemAbbr', 'Fg')
  li('CmpItemKind', 'Fg')
  hl('CmpItemAbbrDeprecated', nil, nil, { 'strikethrough' })
  hl('CmpItemAbbrMatch', '#CA7E03', nil, 'bold')
  li('CmpItemAbbrMatchFuzzy', 'CmpItemAbbrMatch')

  -- nvim-tree.lua
  li('NvimTreeRootFolder', 'Comment')
  li('NvimTreeExecFile', 'Todo')
  li('NvimTreeSpecialFile', 'Function')
  li('NvimTreeFolderIcon', 'Constant')
  li('NvimTreeImageFile', 'Normal')
  li('NvimTreeGitIgnored', 'Debug')
  hl('NvimTreeGitNew', '#42905b', nil, 'italic')
  hl('NvimTreeGitStaged', '#39c064', nil, 'italic')
  hl('NvimTreeGitRenamed', '#507eae', nil, 'italic')
  hl('NvimTreeGitDeleted', '#bd5b5b', nil, 'italic')
  li('NvimTreeGitDirty', 'NvimTreeGitDeleted')
  hl('NvimTreeWindowPicker', '#BDAE9D', '#2A190E', 'bold')
  hl('NvimTreeLspDiagnosticsError', '#EF5350', nil, 'bold')
  li('NvimTreeWinSeparator', 'WinSeparator')
  li('NvimTreeLiveFilterPrefix', 'CurSearch')
  li('NvimTreeLiveFilterValue', 'Search')

  -- ponton.nvim
  hl('WinBar', '#2A211C', '#2A211C')
  hl('WinBarNC', '#2A211C', '#2A211C')
  hl('StatusLine', '#734c36', '#332A25')

  -- suit.nvim
  hl('suitPrompt', '#C7C7FF', '#3f3534', { 'bold', 'italic' })

  -- telescope.nvim
  li('TelescopeNormal', 'Fg')
  hl('TelescopeSelection', nil, '#544236')

  -- lsp_signature.nvim
  hl('codeHint', '#CA7E03', nil, 'italic')
  hl('inlayHint', '#604417', nil, 'italic')

  -- qflist & loclist
  li('qfLineNr', 'NonText')
  li('qfFileName', 'Debug')
  hl('qfTitle', '#BDAE9D', '#432717', 'bold')
  hl('QuickFixLine', nil)

  -- dmap.nvim
  vim.api.nvim_set_hl(
    0,
    'dmapError',
    { fg = '#ff0000', nocombine = true, blend = 60 }
  )
  vim.api.nvim_set_hl(
    0,
    'dmapWarn',
    { fg = '#ffff00', nocombine = true, blend = 60 }
  )
  vim.api.nvim_set_hl(
    0,
    'dmapInfo',
    { fg = '#ffffff', nocombine = true, blend = 60 }
  )
  hl('dmapHint', '#CA7E03', nil)
end

return M
