-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- server capabilities
local default = vim.lsp.protocol.make_client_capabilities()
-- https://cmp.saghen.dev/installation#merging-lsp-capabilities
local blink = require('blink.cmp').get_lsp_capabilities({}, false)
local capabilities = vim.tbl_deep_extend('force', default, blink)

-- fix a warning "multiple different client offset_encodings detected"
-- see https://github.com/neovim/nvim-lspconfig/issues/2184
capabilities = vim.tbl_deep_extend('force', capabilities, {
  offsetEncoding = { 'utf-16' },
  general = {
    positionEncodings = { 'utf-16' },
  },
})

local M = {
  default = capabilities,
}
return M
