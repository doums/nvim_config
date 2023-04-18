-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'jose-elias-alvarez/null-ls.nvim',
  ft = {
    'text',
    'markdown',
    'markdown.mdx',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'sh',
    'css',
    'scss',
    'less',
    'html',
    'json',
    'jsonc',
    'yaml',
    'lua',
    'luau',
  },
}

P.config = function()
  local nl = require('null-ls')

  -- use a private server for LanguageTool-Rust
  local ltrs_default_args = { 'check', '-m', '-r', '--text', '$TEXT' }
  local ltrs_args = ltrs_default_args
  if vim.env.LANGTOOL_HOST then
    table.insert(ltrs_args, 1, '--hostname=' .. vim.env.LANGTOOL_HOST)
  end

  require('null-ls').setup({
    sources = {
      nl.builtins.code_actions.eslint,
      nl.builtins.code_actions.ltrs.with({
        args = ltrs_args,
      }),
      nl.builtins.diagnostics.eslint,
      nl.builtins.diagnostics.shellcheck,
      nl.builtins.diagnostics.cspell.with({
        disabled_filetypes = { 'NvimTree', 'c', 'cpp' },
      }),
      nl.builtins.diagnostics.ltrs.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
        args = ltrs_args,
      }),
      nl.builtins.formatting.prettier,
      nl.builtins.formatting.stylua,
    },
    fallback_severity = vim.diagnostic.severity.HINT,
    capabilities = require('lsp.common').capabilities,
  })
end

return P
