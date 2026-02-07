local P = {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    { 'folke/snacks.nvim', opts = { input = {}, picker = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      ask = {
        prompt = 'opencode',
        blink_cmp_sources = { 'opencode', 'buffer' },
        snacks = {
          icon = '󰢚',
          win = {
            relative = 'cursor',
            row = -2,
            col = 0,
            b = {
              -- TODO blink completion menu cassé
              completion = false,
            },
          },
        },
      },
      select = {
        prompt = 'opencode',
        snacks = {
          layout = {
            preset = 'dropdown',
          },
        },
      },
      provider = {
        wezterm = {
          direction = 'right',
          top_level = false,
          percent = 36,
        },
      },
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    vim.keymap.set({ 'n', 'x' }, '<Leader>a', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode…' })
    vim.keymap.set({ 'n', 'x' }, '<Leader>o', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
  end,
}

return P
