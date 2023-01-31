-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Snippets for Rust

local ls = require('luasnip')
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local i = ls.insert_node

local M = {
  s(
    {
      trig = 'mpl',
      name = 'MPL Header',
      dscr = 'Mozilla Public License v2.O Header',
    },
    fmt(
      [[
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
  ]],
      {}
    )
  ),
  s('prt', fmt([[println!("{}");]], i(0))),
  s('prtd', fmta([[println!("{:#?}", <>);]], i(0))),
  s('fmt', fmta([[format!("{}", <>)]], i(0))),
  s(
    { trig = 'cs', name = 'closure' },
    fmta([[|<>| {<>}]], {
      i(1),
      i(0),
    }, {})
  ),
  s(
    { trig = 'fn', name = 'function declaration' },
    fmta(
      [[
    fn <>(<>) ->> <> {
      <>
    }
		]],
      {
        i(1),
        i(2),
        i(3),
        i(0),
      },
      {}
    )
  ),
  s(
    { trig = 'fn', name = 'function declaration' },
    fmta(
      [[
    fn <>(<>) ->> <> {
        <>
    }
		]],
      {
        i(1),
        i(2),
        i(3),
        i(0),
      },
      {}
    )
  ),
  s(
    { trig = 'fnp', name = 'public function declaration' },
    fmta(
      [[
    pub fn <>(<>) ->> <> {
        <>
    }
		]],
      {
        i(1),
        i(2),
        i(3),
        i(0),
      },
      {}
    )
  ),
}

return M
