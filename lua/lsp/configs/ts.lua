-- typescript-language-server - TypeScript
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls

return {
  on_attach = function(client)
    -- use conform.nvim to handle formatting (Prettier)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
