-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- tsserver - TypeScript

require('lspconfig').ts_ls.setup({ -- TypeScript
  on_attach = function(client)
    -- use conform to handle formatting (Prettier)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = require('lsp.common').capabilities,
})
