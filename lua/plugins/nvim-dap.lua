local P = {
  'mfussenegger/nvim-dap',
}

P.config = function()
  local dap = require('dap')

  -- Keybindings
  vim.keymap.set('n', '<F10>', dap.continue, { desc = 'DAP: Continue' })
  vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'DAP: Step Into' })
  vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'DAP: Step Over' })
  vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'DAP: Step Out' })
  vim.keymap.set(
    'n',
    '<F12>',
    dap.run_to_cursor,
    { desc = 'DAP: Run to Cursor' }
  )
  vim.keymap.set(
    'n',
    '<F11>',
    dap.toggle_breakpoint,
    { desc = 'DAP: Toggle Breakpoint' }
  )
  vim.keymap.set('n', '<leader>dq', dap.terminate, { desc = 'DAP: Terminate' })

  -- Custom signs
  local sign = vim.fn.sign_define
  sign('DapBreakpoint', {
    text = '󰶵',
    texthl = 'DapBreakpoint',
    linehl = '',
    numhl = '',
  })
  sign(
    'DapBreakpointCondition',
    { text = '❱', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' }
  )
  sign(
    'DapLogPoint',
    { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' }
  )
  sign('DapStopped', {
    text = '→',
    texthl = 'DapStoppedPoint',
    linehl = 'DapStoppedLine',
    numhl = '',
    priority = 50,
  })
  sign(
    'DapBreakpointRejected',
    { text = '󰇪', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' }
  )

  dap.defaults.fallback.switchbuf = 'usevisible,usetab,uselast'
  dap.defaults.fallback.external_terminal = {
    command = 'wezterm',
    args = { 'cli', 'split-pane', '--bottom', '--percent=30' },
  }

  -- C/C++/Rust/Zig debugger
  -- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#c-c-rust-via-lldb-vscode
  -- requires sys packages: lldb llvm
  dap.adapters.lldb = {
    type = 'executable',
    command = '/bin/lldb-dap',
    name = 'lldb',
  }
  dap.configurations.zig = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = '${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}',
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      -- internalConsole (in repl)
      -- integratedTerminal (nvim terminal)
      -- externalTerminal (dedicated wezterm split)
      -- ref https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-dap
      console = 'integratedTerminal',
    },
  }
end

return P
