-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

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

vim.api.nvim_create_autocmd('FileType', {
  group = group_id,
  pattern = 'man',
  callback = function(a)
    -- remap leap Q because it is overriden by nvim's manpage
    -- mapping
    vim.keymap.set('n', 'q', '<Plug>(leap-backward-to)', { buffer = a.buf })
  end,
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
    vim.hl.on_yank()
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
