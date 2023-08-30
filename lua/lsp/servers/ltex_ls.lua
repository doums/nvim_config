-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- LSP for ltex-ls
-- https://github.com/valentjn/ltex-ls
--
-- requires ltex-ls to be installed and in the $PATH
-- can be installed from releases https://github.com/valentjn/ltex-ls/releases
-- for settings see https://valentjn.github.io/ltex/settings.html

require('lspconfig').ltex.setup({
  settings = {
    ltex = {
      language = 'en-US',
      languageToolHttpServerUri = vim.env.LANGTOOL_HOST,
      diagnosticSeverity = 'hint',
    },
  },
})
