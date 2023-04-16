-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'numToStr/comment.nvim',
  keys = {
    { '<leader>cc', nil, desc = 'Comment a line' },
    { '<leader>bc', nil, desc = 'Comment a bloc' },
  },
}

P.opts = {
  ignore = '^$',
  toggler = {
    line = '<leader>cc',
    block = '<leader>bc',
  },
  opleader = {
    line = '<leader>c',
    block = '<leader>b',
  },
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
}

return P
