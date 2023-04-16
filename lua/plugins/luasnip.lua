-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'L3MON4D3/LuaSnip',
  ft = { 'typescript', 'typescriptreact', 'lua', 'rust' },
}

P.config = function()
  require('luasnip.loaders.from_lua').load({
    paths = './lua/snippets/ft/',
  })
  require('luasnip').filetype_extend('typescriptreact', { 'typescript' })
end

return P
