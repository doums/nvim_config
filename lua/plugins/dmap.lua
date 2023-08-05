-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'doums/dmap.nvim',
  event = { 'LspAttach', 'DiagnosticChanged' },
  dev = true,
}

P.opts = {
  sources_ignored = { 'cspell' },
  win_align = 'left',
  win_v_offset = 80,
  severity = { min = vim.diagnostic.severity.INFO },
  win_max_height = 10,
}

return P
