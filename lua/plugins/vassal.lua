-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'doums/vassal.nvim',
  cmd = { 'Vassal', 'Vl' },
}

P.config = function()
  require('vassal').commands({
    [[npm i -g typescript typescript-language-server eslint prettier cspell tailwindcss @tailwindcss/language-server]],
  })
end

return P
