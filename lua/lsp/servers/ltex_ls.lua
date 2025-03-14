-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- ltex-ls+ https://github.com/ltex-plus/ltex-ls-plus
-- for settings see https://ltex-plus.github.io/ltex-plus/settings.html

require('lspconfig').ltex_plus.setup({
  settings = {
    ltex = {
      language = _G.lt_lang,
      languageToolHttpServerUri = vim.env.LANGTOOL_HOST,
      diagnosticSeverity = 'hint',
    },
  },
})
