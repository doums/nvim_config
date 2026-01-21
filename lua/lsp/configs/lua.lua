-- lua-ls
-- https://github.com/LuaLS/lua-language-server
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls

return {
  on_init = function(client)
    -- use conform.nvim to handle formatting (stylua)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- disable semantic tokens highlight
    client.server_capabilities.semanticTokensProvider = nil
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      local pcheck = vim.uv.fs_stat(path .. '/.luarc.json')
        or vim.uv.fs_stat(path .. '/.luarc.jsonc')
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
}
