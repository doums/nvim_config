-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- ⚡ enhanced qflist/loclist

local M = {}

local group_id = vim.api.nvim_create_augroup('CustomQuickfix', {})

local layout_map = {
  split = 'new',
  vsplit = 'vertical new',
  tab = 'tabnew',
}

local function go_to_item(data)
  local row = unpack(vim.api.nvim_win_get_cursor(data.win))
  local res
  if data.wintype == 'quickfix' then
    res = vim.fn.getqflist({ idx = row, items = true })
    -- set current qf item
    vim.fn.setqflist({}, 'a', { idx = row })
  else
    res = vim.fn.getloclist(0, { idx = row, items = true })
    -- set current qf item
    vim.fn.setloclist(0, {}, 'a', { idx = row })
  end
  local item = res.items[1]
  vim.cmd('wincmd p')
  vim.cmd(layout_map[data.layout])
  vim.api.nvim_win_set_buf(0, item.bufnr)
  vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
  vim.api.nvim_feedkeys('zz', 'n', false)
end

-- default format for qflist or loclist
function M.qf_format()
  local qf = vim.fn.getqflist({ items = true })
  return vim.tbl_map(function(i)
    return string.format(
      '%s %s L%s:%s',
      vim.fn.bufname(i.bufnr),
      i.text,
      i.lnum,
      i.col
    )
  end, qf.items)
end

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = group_id,
  pattern = 'quickfix',
  callback = function(ev)
    local buf = ev.buf
    local win = vim.fn.bufwinid(buf)
    local wintype = vim.fn.win_gettype(win)
    local qf
    if wintype == 'quickfix' then
      qf = vim.fn.getqflist({ title = true, size = true })
    elseif wintype == 'loclist' then
      qf = vim.fn.getloclist(win, { title = true, size = true })
    else
      return
    end
    vim.api.nvim_win_set_option(win, 'signcolumn', 'yes:1')
    vim.api.nvim_win_set_option(win, 'number', false)
    vim.api.nvim_win_set_option(win, 'relativenumber', false)
    vim.api.nvim_win_set_option(win, 'colorcolumn', '')
    vim.api.nvim_win_set_option(win, 'wrap', false)
    vim.api.nvim_win_set_option(
      win,
      'winbar',
      '%#qfTitle# ' .. qf.title .. ' ' .. qf.size .. '  %#WinBar#'
    )
    vim.keymap.set(
      'n',
      'q',
      wintype == 'quickfix' and '<cmd>ccl<cr>' or '<cmd>lcl<cr>',
      { silent = true, buffer = buf }
    )
    vim.keymap.set('n', '<C-s>', function()
      go_to_item({ wintype = wintype, win = win, layout = 'split' })
    end, { silent = true, buffer = buf })
    vim.keymap.set('n', '<C-v>', function()
      go_to_item({ wintype = wintype, win = win, layout = 'vsplit' })
    end, { silent = true, buffer = buf })
    vim.keymap.set('n', '<C-t>', function()
      go_to_item({ wintype = wintype, win = win, layout = 'tab' })
    end, { silent = true, buffer = buf })
  end,
})

return M