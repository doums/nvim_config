local P = {
  'doums/suit.nvim',
  event = 'VeryLazy',
  -- dev = true,
}

P.opts = {
  input = {
    default_prompt = '↓',
    border = { ' ', ' ', ' ', ' ', '', '', '', ' ' },
    max_width = 40,
  },
  select = {
    default_prompt = '≡',
    border = { ' ', ' ', ' ', ' ', '', '', '', ' ' },
    max_width = 30,
  },
}

return P
