local P = {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<A-e>',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
}

P.opts = {
  formatters_by_ft = {
    rust = { 'rustfmt' },
    lua = { 'stylua' },
    sh = { 'shfmt' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    css = { 'prettier' },
    scss = { 'prettier' },
    less = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    graphql = { 'prettier' },
    html = { 'prettier' },
    handlebars = { 'prettier' },
  },
  -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
  format_on_save = nil,
  formatters = {
    shfmt = {
      -- use 2 spaces, fuck tabs
      prepend_args = { '-i', '2' },
    },
  },
}

P.init = function()
  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end

return P
