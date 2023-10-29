-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local qf = require('tools.qf')

local group_id = vim.api.nvim_create_augroup('InitLua', {})

-- after loading a colorscheme, re-generate hl groups
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    require('hl').hl()
    vim.notify(
      '✓ hl groups generated',
      vim.log.levels.INFO,
      { title = 'nvim-config' }
    )
  end,
})

-- retrieve any external changes and refresh the buffer
vim.api.nvim_create_autocmd('CursorHold', {
  group = group_id,
  pattern = '*',
  callback = function()
    if #vim.opt.buftype:get() == 0 then
      vim.cmd('checktime %')
    end
  end,
})

-- hide column numbers when viewing man pages
vim.api.nvim_create_autocmd('FileType', {
  group = group_id,
  pattern = 'man',
  command = 'set nonumber',
})

-- highlight the selection when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  group = group_id,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = group_id,
  pattern = '*',
  callback = function(args)
    -- current buffer diagnostics
    vim.keymap.set('n', '<A-q>', function()
      local list = vim.diagnostic.toqflist(vim.diagnostic.get(args.buf))
      qf.on_ll_list({
        items = qf.qf_d_sort(list, true),
        title = '~',
        context = { buf_diagnostics = args.buf },
        quickfixtextfunc = qf.ll_d_format,
      })
    end, { buffer = args.buf })

    -- all buffers diagnostics
    vim.keymap.set('n', '<A-S-q>', function()
      local list = vim.diagnostic.toqflist(vim.diagnostic.get(nil))
      qf.on_qf_list({
        items = qf.qf_d_sort(list),
        title = '≈',
        context = { all_diagnostics = true },
        quickfixtextfunc = qf.qf_d_format,
      })
    end, { buffer = args.buf })
  end,
})

local diag_group = vim.api.nvim_create_augroup('lspDiagnosticLiveUpdate', {})

-- live update all buffers diagnostics list in qflist
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = diag_group,
  callback = function()
    -- retrieve all normal windows
    local qflist = vim.fn.getqflist({ context = true })

    -- if qflist is listing all diagnostics, do update
    if qflist.context.all_diagnostics then
      local d = vim.diagnostic.toqflist(vim.diagnostic.get(nil))
      vim.fn.setqflist({}, 'r', { items = qf.qf_d_sort(d) })
    end
  end,
})

-- live update buffer diagnostics in loclists
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = diag_group,
  callback = function()
    -- retrieve all normal windows
    local wins = vim.tbl_filter(function(win)
      return win.quickfix == 0 and win.loclist == 0
    end, vim.fn.getwininfo())

    -- retrieve corresponding loclist for each windows
    local loclists = vim.tbl_map(function(win)
      return vim.fn.getloclist(
        win.winid,
        { context = true, winid = true, title = true }
      )
    end, wins)
    -- only keep the ones with data
    loclists = vim.tbl_filter(function(win)
      return win and win.context.buf_diagnostics
    end, loclists)

    -- update diagnostic lists
    for _, ll in ipairs(loclists) do
      local d =
        vim.diagnostic.toqflist(vim.diagnostic.get(ll.context.buf_diagnostics))

      vim.fn.setloclist(ll.winid, {}, 'r', { items = qf.qf_d_sort(d, true) })
    end
  end,
})

