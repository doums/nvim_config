-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'doums/suit.nvim',
  event = 'VeryLazy',
  -- dev = true,
}

P.opts = {
  input = {
    default_prompt = '↓',
    border = { ' ', ' ', ' ', ' ', '', '', '', ' ' },
    max_width = 40,
  },
  select = {
    default_prompt = '≡',
    border = { ' ', ' ', ' ', ' ', '', '', '', ' ' },
    max_width = 30,
  },
}

return P
