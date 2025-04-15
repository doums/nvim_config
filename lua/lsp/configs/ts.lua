-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- typescript-language-server - TypeScript
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls

return {
  on_attach = function(client)
    -- use conform.nvim to handle formatting (Prettier)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
