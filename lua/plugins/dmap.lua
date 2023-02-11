-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Config for dmap.nvim

require('dmap').setup({
  sources_ignored = { 'cspell' },
  v_offset = 1,
  severity = { min = vim.diagnostic.severity.INFO },
})
