-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {
  s({ trig = 'she', desc = 'shebang' }, t({ '#!/bin/bash', '' })),
  s(
    { trig = 'fn', desc = 'Function declaration' },
    fmta(
      [[
      <>() {
        <>
      }
		  ]],
      {
        i(1, 'name'),
        i(0, 'command…'),
      }
    )
  ),
}

return M
