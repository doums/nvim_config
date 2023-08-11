-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- LSP config for Rust - rust-analyzer

require('lspconfig').rust_analyzer.setup({
  capabilities = require('lsp.common').capabilities,
  settings = {
    ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
  },
})
