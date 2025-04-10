-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- lua-ls
-- https://github.com/LuaLS/lua-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls

require('lspconfig').lua_ls.setup({
  on_init = function(client)
    -- use guard.nvim to handle formatting (stylua)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      local pcheck = vim.loop.fs_stat(path .. '/.luarc.json')
        or vim.loop.fs_stat(path .. '/.luarc.jsonc')
      if path ~= vim.fn.stdpath('config') and pcheck then
        return
      end
    end
    client.config.settings.Lua =
      vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = { version = 'LuaJIT' },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
          },
        },
      })
  end,
  settings = {
    Lua = {
      telemetry = { enable = false },
    },
  },
})
