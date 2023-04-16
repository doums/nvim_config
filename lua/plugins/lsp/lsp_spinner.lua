-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'doums/lsp_spinner.nvim',
  event = 'LspAttach',
}

P.opts = {
  spinner = { '▪', '■', '□', '▫' },
  interval = 80,
  placeholder = ' ',
}

return P
