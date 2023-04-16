-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {
  -- {
  --   'neovim/nvim-lspconfig',
  --   ft = {
  --     'markdown',
  --     'lua',
  --     'rust',
  --     'javascript',
  --     'typescript',
  --     'javascriptreact',
  --     'typescriptreact',
  --     'html',
  --   },
  -- },
  {
    'ray-x/lsp_signature.nvim',
    event = 'LspAttach',
  },
}

return M
