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
    vim.api.nvim_set_option_value('signcolumn', 'yes:1', { win = win })
    vim.api.nvim_set_option_value('number', false, { win = win })
    vim.api.nvim_set_option_value('relativenumber', false, { win = win })
    vim.api.nvim_set_option_value('colorcolumn', '', { win = win })
    vim.api.nvim_set_option_value('wrap', false, { win = win })
    vim.api.nvim_set_option_value(
      'winbar',
      '%#qfTitle# ' .. qf.title .. ' ' .. qf.size .. '  %#WinBar#',
      { win = win }
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

local qf_type_to_severity = {
  E = 1,
  W = 2,
  I = 3,
  H = 4,
  N = 4,
}

function M.qf_d_sort(d, opts)
  -- table.sort is tricky, wrap it in a pcall to be safe
  local success, _ = pcall(function()
    table.sort(d, function(a, b)
      local a_severity = qf_type_to_severity[a.type] or 1
      local b_severity = qf_type_to_severity[b.type] or 1
      -- try sorting by severity
      if a_severity < b_severity then
        return true
      elseif a_severity > b_severity then
        return false
      end
      -- try sorting by buffer
      if opts.bufnr then
        if a.bufnr < b.bufnr then
          return true
        elseif a.bufnr > b.bufnr then
          return false
        end
      end
      -- try sorting by line number
      if opts.lnum and a.lnum < b.lnum then
        return true
      end
      return false
    end)
  end)
  if not success then
    vim.notify(
      '⚠ sorting diagnostics list failed',
      vim.log.levels.WARN,
      { title = 'qf_d_sort' }
    )
  end
  return d
end

local qf_type_map = {
  E = 'E',
  W = 'W',
  I = 'I',
  N = 'H',
}

-- format diagnostics list displayed in a loclist
function M.ll_d_format(d)
  local ll = vim.fn.getloclist(d.winid, { items = true })
  return vim.tbl_map(function(i)
    return string.format('%s %s L%s', qf_type_map[i.type], i.text, i.lnum)
  end, ll.items)
end

-- format diagnostics list displayed in the qflist
function M.qf_d_format(_)
  local qf = vim.fn.getqflist({ items = true })
  return vim.tbl_map(function(i)
    return string.format(
      '%s %s %s L%s',
      qf_type_map[i.type],
      vim.fn.bufname(i.bufnr),
      i.text,
      i.lnum
    )
  end, qf.items)
end

function M.on_qf_list(options)
  vim.fn.setqflist({}, ' ', options)
  if #options.items > 1 then
    vim.cmd('botright copen 5')
  end
  vim.cmd('cfirst')
end

function M.on_ll_list(options, jump_on_first)
  vim.fn.setloclist(0, {}, ' ', options)
  if #options.items > 1 then
    vim.cmd('lopen 5')
  end
  if jump_on_first then
    vim.cmd('lfirst')
  end
end

return M
