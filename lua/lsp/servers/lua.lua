-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- lua-ls
-- https://github.com/LuaLS/lua-language-server

local runtime_path = vim.tbl_extend(
  'keep',
  vim.split(package.path, ';'),
  { '?/init.lua', '?.lua', 'lua/?.lua', 'lua/?/init.lua' }
)
require('lspconfig').lua_ls.setup({ -- Lua
  on_attach = function(client)
    -- use guard.nvim to handle formatting (stylua)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = require('lsp.common').capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = runtime_path },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        -- Disable that prompt about `luassert` on server start
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})
