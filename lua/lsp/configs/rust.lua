-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer

return {
  settings = {
    ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
  },
}
