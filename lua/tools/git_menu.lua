-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Custom menu for git operations

local M = {}

local gs = require('gitsigns')

local git_static_actions = {
  ['Log'] = Snacks.picker.git_log,
  ['Log ~'] = Snacks.picker.git_log_file,
  ['Diff'] = gs.diffthis,
  ['Diff ~'] = function()
    gs.diffthis('~')
  end,
  ['Changelist'] = function()
    gs.setloclist(0, 'all')
  end,
  ['Refresh'] = gs.refresh,
  ['Stage buffer'] = gs.stage_buffer,
  ['Rollback'] = function()
    vim.ui.select({ 'OK', 'Cancel' }, {
      prompt = 'Rollback',
    }, function(choice)
      if choice == 'OK' then
        gs.reset_buffer()
      end
    end)
  end,
}

function M.open()
  local git_actions =
    vim.tbl_extend('keep', gs.get_actions(), git_static_actions)
  local items = vim.tbl_keys(git_actions)
  table.sort(items)
  vim.ui.select(items, {
    prompt = 'git',
  }, function(choice)
    if choice then
      git_actions[choice]()
    end
  end)
end

return M
