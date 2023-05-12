-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'ggandor/leap.nvim',
}

-- stylua: ignore start
P.opts = {
  safe_labels = { 's', 'f', 'n', 'u', 't', 'b', 'g', 'F',
    'L', 'N', 'H', 'G', 'M', 'U', 'T', 'Z' },
  labels = { 's', 'f', 'n', 'g', 'h', 'v', 'b', 'w', 'y', 'd',
    'q', 'z', 'c', 'x', 't', 'u', 'r', 'i', 'a', 'o', 'e' },
}
-- stylua: ignore end

P.init = function()
  vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward-to)')
  vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-backward-to)')
  require('leap').add_default_mappings()
end

return P
