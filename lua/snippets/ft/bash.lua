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
