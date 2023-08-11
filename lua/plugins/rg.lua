-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'doums/rg.nvim',
  cmd = { 'Rg', 'Rgf', 'Rgp', 'Rgfp' },
  dev = true,
}

P.opts = {
  qf_format = require('tools.qf').qf_format,
}

return P
