local M = {}

local function paste()
  return {
    vim.split(vim.fn.getreg(''), '\n'),
    vim.fn.getregtype(''),
  }
end

function M.init()
  if vim.env.SSH_TTY then
    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
      },
      -- see https://github.com/neovim/neovim/discussions/28010
      -- https://github.com/wez/wezterm/issues/2050
      paste = {
        ['+'] = paste,
        ['*'] = paste,
      },
    }
  end
end

return M
