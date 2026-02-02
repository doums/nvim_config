-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#typos_lsp
-- https://github.com/tekumara/typos-lsp/blob/main/docs/neovim-lsp-config.md

return {
  init_options = {
    config = '~/.config/typos/typos.toml',
    diagnosticSeverity = 'Info', -- Error, Warning, Info or Hint
  },
}
