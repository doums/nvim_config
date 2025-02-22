-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'zbirenbaum/copilot.lua',
  -- do not auto load when required from cmp
  module = false,
  cmd = 'Copilot',
  keys = {
    {
      '<M-p>',
      function()
        if _G.copilot == 'ON' then
          require('copilot.panel').open()
        else
          vim.notify('copilot is off', vim.log.levels.WARN)
        end
      end,
      desc = 'Open Copilot panel',
    },
    {
      '<F3>',
      function()
        _G.copilot = 'ON'
        vim.cmd('Copilot enable')
      end,
      desc = 'Enable Copilot',
    },
    {
      '<F4>',
      function()
        -- TODO `:Copilot disable` throws an error
        -- see https://github.com/zbirenbaum/copilot.lua/issues/355
        local function disable()
          vim.cmd('Copilot disable')
        end
        pcall(disable)
        _G.copilot = 'OFF'
        vim.cmd('Copilot status')
      end,
      desc = 'Disable Copilot',
    },
    {
      '<F6>',
      '<cmd>Copilot status<CR>',
      desc = 'Get Copilot state',
    },
  },
}

P.opts = {
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = '<C-k>',
      jump_next = '<C-j>',
      accept = '<CR>',
      refresh = '<M-r>',
      open = '<M-CR>',
    },
    layout = {
      position = 'bottom',
      ratio = 0.20,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = '<M-CR>',
      accept_word = false,
      accept_line = false,
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<M-u>',
    },
  },
  filetypes = {
    markdown = true,
    sh = function()
      if
        string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*')
      then
        -- disable for .env files
        return false
      end
      return true
    end,
  },
}

return P
