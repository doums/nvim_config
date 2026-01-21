local M = {
  s(
    {
      trig = 'mpl',
      desc = 'MPL Header',
    },
    fmt(
      [[
  -- This Source Code Form is subject to the terms of the Mozilla Public
  -- License, v. 2.0. If a copy of the MPL was not distributed with this
  -- file, You can obtain one at https://mozilla.org/MPL/2.0/.

  ]],
      {}
    )
  ),
  s(
    {
      trig = 'mod',
      desc = 'Lua module setup',
    },
    fmta(
      [[
  local M = {}

  <>

  return M
  ]],
      { i(0) }
    )
  ),
  s('prt', fmt([[print({})]], i(0))),
  s('vprt', fmt([[vim.print({})]], i(0))),
  s('fmt', fmt([[string.format('%s', {})]], i(0))),
  s('req', fmt([[local {} = require('{}')]], { i(0), i(1) })),
  s(
    { trig = 'lfn', desc = 'Local function declaration' },
    fmta(
      [[
    local function <>(<>)
      <>
    end
		]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
  s(
    { trig = 'fn', desc = 'Function declaration' },
    fmta(
      [[
    function <>(<>)
      <>
    end
		]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),
  s(
    { trig = 'ifn', desc = 'Inline function declaration' },
    fmta(
      [[
    function (<>)
      <>
    end
		]],
      {
        i(1),
        i(0),
      }
    )
  ),
}

return M
