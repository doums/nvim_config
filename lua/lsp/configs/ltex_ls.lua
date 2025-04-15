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
  on_attach = function(client, bufnr)
    -- custom command to switch the lang
    vim.api.nvim_buf_create_user_command(bufnr, 'Ltool', function(a)
      local lang = a.fargs[1] == 'en' and 'en-US' or 'fr-FR'
      if _G._pdcfg.lt_lang == lang then
        vim.notify('lang is already set to ' .. lang, vim.log.levels.WARN)
        return
      end
      _G._pdcfg.lt_lang = lang
      -- reload the server (see :h lsp-faq)
      vim.lsp.stop_client(client.id)
      vim.lsp.config.ltex_plus.settings.ltex.language = lang
      -- some delay is needed for the server to close properly
      -- before restarting it
      vim.defer_fn(function()
        vim.cmd(':edit')
        vim.notify('✓ lang set to ' .. lang)
      end, 2000)
    end, {
      nargs = 1,
      complete = function()
        return { 'en', 'fr' }
      end,
    })
  end,
}
