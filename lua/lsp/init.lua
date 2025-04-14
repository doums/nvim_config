-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

-- LSP server configs
-- k: server name
-- v: server config filename `lua/lsp/configs/<filename>.lua`
--    or `false` when no custom config is needed
-- TODO add zls and tailwind once migrated to vim.lsp.config
local servers = {
  clangd = false,
  lua_ls = 'lua',
  rust_analyzer = 'rust',
  ltex_plus = 'ltex_ls',
  nushell = false,
  ts_ls = 'ts',
}

function M.setup()
  -- configure LSP diagnostic
  require('lsp.diagnostic').setup()
  -- configure `LspAttach` and `LspDetach` events
  require('lsp.attach').setup()

  -- set the default capabilities for all clients
  vim.lsp.config('*', {
    capabilities = require('lsp.capabilities').default,
  })

  vim.iter(servers):each(function(server, config)
    if config then
      -- load LSP server config
      local ok, cfg = pcall(require, 'lsp.configs.' .. config)
      if not ok then
        vim.notify(
          '✗ failed to load LSP server config: ' .. config,
          vim.log.levels.ERROR
        )
        return
      end
      -- load the config
      vim.lsp.config(server, cfg)
    end
    vim.lsp.enable(server)
  end)
end

return M
