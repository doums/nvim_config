local P = {
  'zbirenbaum/copilot.lua',
  -- do not auto load when required from cmp
  module = false,
  cmd = 'Copilot',
  keys = {
    {
      '<F7>',
      function()
        if _G._pdcfg.copilot then
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
        _G._pdcfg.copilot = true
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
        _G._pdcfg.copilot = false
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
      accept = '<M-Tab>',
      accept_word = '<M-m>',
      accept_line = '<M-l>',
      next = '<M-]>',
      prev = '<M-[>',
      dismiss = '<M-c>',
    },
  },
  filetypes = {
    markdown = true,
  },
  should_attach = function(_, bufname)
    if not _G._pdcfg.copilot then
      return false
    end
    if string.match(bufname, '^%.env.*') then
      return false
    end
    return true
  end,
}

return P
