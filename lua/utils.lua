-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Helper functions

local M = {}

function M.hl(name, fg, bg, style, sp)
  local hl_map = { fg = fg, bg = bg, sp = sp }
  if type(style) == 'string' then
    hl_map[style] = 1
  elseif type(style) == 'table' then
    for _, v in ipairs(style) do
      hl_map[v] = 1
    end
  end
  vim.api.nvim_set_hl(0, name, hl_map)
end

function M.li(target, source)
  vim.api.nvim_set_hl(0, target, { link = source })
end

function M.scroll(dir)
  local c = math.ceil(vim.api.nvim_win_get_height(0) / 2.5)
  local key
  if dir == 'up' then
    key = vim.api.nvim_replace_termcodes('<C-y>', true, false, true)
  else
    key = vim.api.nvim_replace_termcodes('<C-e>', true, false, true)
  end
  vim.api.nvim_feedkeys(c .. key, 'nt', false)
end

vim.api.nvim_create_user_command('GetHl', function()
  vim.print(vim.treesitter.get_captures_at_cursor(0))
end, {})

return M
