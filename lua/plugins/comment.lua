local P = {
  'numToStr/comment.nvim',
  keys = {
    { '<leader>c', nil, desc = 'Comment a selection', mode = { 'o', 'v' } },
    {
      '<leader>b',
      nil,
      desc = 'Block comment a selection',
      mode = { 'o', 'v' },
    },
    { '<leader>cc', nil, desc = 'Comment a line' },
    { '<leader>bc', nil, desc = 'Block comment a line' },
  },
}

P.opts = {
  ignore = '^$',
  toggler = {
    line = '<leader>cc',
    block = '<leader>bc',
  },
  opleader = {
    line = '<leader>c',
    block = '<leader>b',
  },
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
}

return P
