-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- LSP config for Rust - rust-analyzer
local P = {
  'simrat39/rust-tools.nvim',
  -- ft = { 'rust' },
}

P.config = function()
  require('rust-tools').setup({
    tools = {
      hover_with_actions = false,
      inlay_hints = {
        auto = true,
        parameter_hints_prefix = '← ',
        other_hints_prefix = '→ ',
        highlight = 'inlayHint',
      },
      hover_actions = { border = 'none' },
    },
    server = { -- rust-analyzer server options
      capabilities = require('lsp.common').capabilities,
      settings = {
        ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
      },
    },
  })
end

return P
