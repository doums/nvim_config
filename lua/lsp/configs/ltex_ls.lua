-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ltex_plus
-- ltex-ls+ https://github.com/ltex-plus/ltex-ls-plus
-- for settings see https://ltex-plus.github.io/ltex-plus/settings.html

return {
  settings = {
    ltex = {
      language = _G._pdcfg.lt_lang,
      languageToolHttpServerUri = vim.env.LANGTOOL_HOST,
      diagnosticSeverity = 'hint',
    },
  },
}
