local P = {
  'mfussenegger/nvim-lint',
}

local langs = {
  lua = {},
  typescript = { 'eslint' },
  typescriptreact = { 'eslint' },
  javascript = { 'eslint' },
  javascriptreact = { 'eslint' },
  css = { 'eslint' },
  html = {},
  htmldjango = {},
  json = {},
  yaml = {},
  markdown = {},
  handlebars = {},
  grahql = {},
  rust = {},
  text = {},
}

P.config = function()
  require('lint').linters.cspell = require('linters.cspell')

  -- add cspell to all defined languages
  vim.iter(langs):each(function(_, config)
    table.insert(config, 'cspell')
  end)

  require('lint').linters_by_ft = langs

  vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
    callback = function()
      require('lint').try_lint()
    end,
  })
end

return P
