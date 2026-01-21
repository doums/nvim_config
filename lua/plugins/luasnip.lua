-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  ft = { 'typescript', 'typescriptreact', 'lua', 'rust' },
}

P.config = function()
  -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
  require('luasnip.loaders.from_lua').lazy_load({
    paths = './lua/snippets/ft/',
  })
  require('luasnip').filetype_extend('typescriptreact', { 'typescript' })
  require('luasnip').filetype_extend('sh', { 'bash' })
end

return P
