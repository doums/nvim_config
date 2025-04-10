-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'ggandor/leap.nvim',
}

P.opts = {
  safe_labels = 'fsnutbgFLNHGMUTZ',
  labels = 'fsnghvbwydqzcxturiaoe',
  substitute_chars = { ['\r'] = '¬' },
  equivalence_classes = {
    ' \t\r\n',
    'eéè',
    'aàâ',
    'iî',
    'oô',
    'uùû',
  },
}

P.init = function()
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward-to)')
  vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-backward-to)')
  require('leap').add_default_mappings()
end

return P
