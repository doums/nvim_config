-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'ray-x/lsp_signature.nvim',
      event = 'LspAttach',
    },
  },
}

P.config = function()
  require('lsp')
  require('lsp.servers.lua')
  require('lsp.servers.rust')
  require('lsp.servers.zls')
  -- require('lsp.servers.c')
  require('lsp.servers.typescript')
  require('lsp.servers.go')
  require('lsp.servers.tailwind')
  require('lsp.servers.ltex_ls')
end

return P
