-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'neovim/nvim-lspconfig',
}

P.config = function()
  require('lsp.servers.lua')
  require('lsp.servers.c')
  require('lsp.servers.typescript')
  require('lsp.servers.tailwind')
end

return P
