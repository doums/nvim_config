-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'ggandor/leap.nvim',
  dependencies = {
    'doums/monark.nvim',
    opts = {},
  },
}

P.opts = {
  safe_labels = 'fsnutbgFLNHGMUTZ',
  labels = 'fsnghvbwydqzcxturiaoe',
  substitute_chars = { ['\r'] = '¬' },
  equivalence_classes = {
    ' \t\r\n',
    'eéèê',
    'aàâ',
    'iîï',
    'oô',
    'uùû',
  },
}

P.init = function()
  local l = require('leap')
  vim.keymap.set({ 'n' }, 'f', '<Plug>(leap-forward)')
  vim.keymap.set({ 'x', 'o' }, 'f', function()
    l.leap({ offset = 1, inclusive = true })
  end)
  vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-backward)')
end

return P
