-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- EFM Language Server
-- https://github.com/mattn/efm-langserver

-- using efmls-configs-nvim for premade linters and formatters
-- configs
-- https://github.com/creativenull/efmls-configs-nvim

-- use custom config for cspell to override the default severity
-- to HINT
local cspell = require('linters.cspell')
local shellcheck = require('linters.shellcheck')
local eslint = require('efmls-configs.linters.eslint')
local prettier = require('efmls-configs.formatters.prettier')
local stylua = require('efmls-configs.formatters.stylua')
local shfmt = require('efmls-configs.formatters.shfmt')

local languages = {
  lua = { stylua },
  sh = { shellcheck, shfmt },
  typescript = { eslint, prettier },
  typescriptreact = { eslint, prettier },
  javascript = { eslint, prettier },
  javascriptreact = { eslint, prettier },
  css = { eslint, prettier },
  scss = { eslint, prettier },
  less = { eslint, prettier },
  html = { prettier },
  json = { prettier },
  yaml = { prettier },
  markdown = { prettier },
  handlebars = { prettier },
  grahql = { prettier },
  rust = {},
  text = {},
}

-- add cspell to all defined languages
vim.iter(languages):each(function(_, config)
  table.insert(config, cspell)
end)

require('lspconfig').efm.setup({
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  filetypes = vim.tbl_keys(languages),
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
})
