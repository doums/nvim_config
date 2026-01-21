local P = {
  'doums/vassal.nvim',
  cmd = { 'Vassal', 'Vl' },
}

P.config = function()
  require('vassal').commands({
    [[npm i -g bash-language-server typescript typescript-language-server eslint prettier cspell tailwindcss @tailwindcss/language-server]],
  })
end

return P
