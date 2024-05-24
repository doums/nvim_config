-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- File system operations

local M = {}

function M.fs_init()
  -- ~/.local/share/nvim/db
  local db_path = vim.fn.stdpath('data') .. '/db'

  -- create the db directory if it does not exist
  if not vim.uv.fs_stat(db_path) then
    local res = vim.uv.fs_mkdir(db_path, 511)
    if res then
      vim.notify(
        '✓ created db directory',
        vim.log.levels.INFO,
        { title = 'nvim-config' }
      )
    else
      vim.notify(
        '✗ failed to create db directory',
        vim.log.levels.ERROR,
        { title = 'nvim-config' }
      )
    end
  end
end

return M
