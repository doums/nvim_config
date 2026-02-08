local P = {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
}

P.config = function()
  local dapui = require('dapui')

  dapui.setup({
    controls = {
      element = 'repl',
      enabled = true,
      icons = {
        disconnect = '󱎘',
        pause = '󰏤',
        play = '󰐊',
        run_last = '󱞸',
        step_back = '󰓕',
        step_into = '󰆹',
        step_out = '󰆸',
        step_over = '󰓗',
        terminate = '󰓛',
      },
    },
    floating = { border = 'bold' },
    icons = {
      collapsed = '▸',
      current_frame = '▸',
      expanded = '▾',
    },
    layouts = {
      {
        elements = {
          {
            id = 'scopes',
            size = 0.7,
          },
          {
            id = 'stacks',
            size = 0.3,
          },
        },
        position = 'right',
        size = 40,
      },
      {
        elements = {
          {
            id = 'repl',
            size = 0.5,
          },
          {
            id = 'console',
            size = 0.5,
          },
        },
        position = 'bottom',
        size = 10,
      },
    },
  })

  vim.keymap.set('n', '<F6>', dapui.toggle)
  -- hover symbol under cursor in float win
  vim.keymap.set({ 'n', 'v' }, '<Leader>dd', function()
    dapui.eval(nil, { enter = true })
  end)
end

return P
