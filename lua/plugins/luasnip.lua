local P = {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  ft = { 'typescript', 'typescriptreact', 'lua', 'rust', 'zig' },
}

P.config = function()
  -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#loaders
  require('luasnip.loaders.from_lua').lazy_load({
    paths = './lua/snippets/ft/',
  })
  require('luasnip').filetype_extend('typescriptreact', { 'typescript' })
  require('luasnip').filetype_extend('sh', { 'bash' })
end

return P
