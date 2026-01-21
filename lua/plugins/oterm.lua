local P = {
  'doums/oterm.nvim',
  keys = {
    { '<M-t>', nil, desc = 'Open a terminal' },
    { '<M-y>', nil, desc = 'Open a terminal in a vertical split' },
    { '<F2>', nil, desc = 'Open gitui' },
    { '<F5>', nil, desc = 'Open nnn' },
  },
  -- dev = true,
}

P.config = function()
  local map = vim.keymap.set
  local open = require('oterm').open

  require('oterm').setup({
    win_api = {
      border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
    },
  })

  map('n', '<M-t>', open)
  map('n', '<M-y>', function()
    open({ layout = 'vsplit' })
  end)
  map('n', '<F5>', function()
    open({
      name = 'nnn',
      layout = 'center',
      height = 0.7,
      width = 0.6,
      command = 'nnn',
    })
  end)
  map('n', '<F2>', function()
    open({
      name = 'gitui',
      layout = 'center',
      height = 0.8,
      width = 0.8,
      command = 'gitui',
    })
  end)
end

return P
