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

-- show concealed characters in help files
vim.api.nvim_create_autocmd('FileType', {
  group = group_id,
  pattern = 'help',
  callback = function()
    vim.o.conceallevel = 1
  end,
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
      -- TODO vim.diagnostic.setloclist() should be used here
      -- but it's not sorting diagnostics by severity
      -- so we have to do it manually
      local list = vim.diagnostic.toqflist(vim.diagnostic.get(args.buf))
      local sorted = qf.qf_d_sort(list, { lnum = true })
      qf.on_ll_list({
        items = sorted,
        title = '~',
        context = { buf_diagnostics = args.buf },
        quickfixtextfunc = qf.ll_d_format,
      })
    end, { buffer = args.buf })

    -- all buffers diagnostics
    vim.keymap.set('n', '<A-S-q>', function()
      -- TODO vim.diagnostic.setqflist() should be used here
      -- but it's not sorting diagnostics by severity
      -- so we have to do it manually
      local list = vim.diagnostic.toqflist(vim.diagnostic.get(nil))
      local sorted = qf.qf_d_sort(list, { bufnr = true, lnum = true })
      qf.on_qf_list({
        items = sorted,
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
      local items = qf.qf_d_sort(d, { bufnr = true, lnum = true })
      vim.fn.setqflist({}, 'r', { items = items })
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

      vim.fn.setloclist(
        ll.winid,
        {},
        'r',
        { items = qf.qf_d_sort(d, { lnum = true }) }
      )
    end
  end,
})

-- mute cursor when nvim lost focus
local _cursor = vim.o.guicursor
vim.api.nvim_create_autocmd({ 'FocusLost' }, {
  group = group_id,
  callback = function()
    vim.o.guicursor = 'a:nocursor'
  end,
})
vim.api.nvim_create_autocmd({ 'FocusGained' }, {
  group = group_id,
  callback = function()
    vim.o.guicursor = _cursor
  end,
})
