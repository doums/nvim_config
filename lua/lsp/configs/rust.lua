-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#rust_analyzer

return {
  settings = {
    ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
  },
}
