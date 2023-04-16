-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- LSP config for Rust - rust-analyzer
local P = {
  'jose-elias-alvarez/null-ls.nvim',
  ft = {
    'c',
    'rust',
    'markdown',
    'lua',
    'sh',
    'typescript',
    'typescriptreact',
    'javascript',
    'javascriptreact',
    'html',
    'cpp',
  },
}

P.config = function()
  local nl = require('null-ls')

  require('null-ls').setup({
    sources = {
      nl.builtins.code_actions.eslint,
      nl.builtins.code_actions.ltrs,
      nl.builtins.diagnostics.eslint,
      nl.builtins.diagnostics.shellcheck,
      nl.builtins.diagnostics.cspell.with({
        disabled_filetypes = { 'NvimTree', 'c', 'cpp' },
      }),
      nl.builtins.diagnostics.ltrs.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
      }),
      nl.builtins.formatting.prettier,
      nl.builtins.formatting.stylua,
    },
    fallback_severity = vim.diagnostic.severity.HINT,
    capabilities = require('lsp.common').capabilities,
  })
end

return P
