-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local fn = vim.fn
local lvl = vim.log.levels
local rg_cmd = 'rg --vimgrep'
local rg_cmd_H = rg_cmd .. ' --hidden'
local rg_cmd_I = rg_cmd .. ' --no-ignore'
local rg_cmd_HI = rg_cmd .. ' --hidden' .. ' --no-ignore'

local M = {}

-- command! -nargs=+ Grep execute 'silent grep! <args>' | copen

local function on_exit(id, code)
  if code == 0 then
    vim.notify(string.format('✓ [%s]', id), lvl.INFO)
  else
    vim.notify(
      string.format('✕ [%s] command failed, exit code [%d]', id, code),
      lvl.ERROR
    )
  end
end

local function on_event(chan_id, data, event)
  table.remove(data)
  fn.setqflist({}, 'r', { title = 'Search', lines = data })
  vim.cmd('copen')
end

local case_modes = {
  ['default'] = '',
  ['smart'] = '--smart-case',
  ['sensitive'] = '--case-sensitive',
  ['ignore'] = '--ignore-case',
}

local filters = {
  ['default'] = '',
  ['hidden'] = '--hidden',
  ['no ignore'] = '--no-ignore',
  ['both'] = { '--hidden', '--ignore-case' },
}

local function spawn_rg(cmd, args)
  local command = cmd .. ' ' .. args
  vim.notify(string.format('running rg [%s]', command), lvl.INFO)
  local job_id = fn.jobstart(command, {
    on_stdout = on_event,
    on_exit = on_exit,
    stdout_buffered = true,
    pty = true,
  })
  if job_id == 0 then
    vim.notify('[rg] invalid argument', lvl.ERROR)
    return
  elseif job_id == -1 then
    vim.notify('[rg] not executable', lvl.ERROR)
    return
  end
end

function M.rg()
  local command = rg_cmd
  local case_mode
  local filter
  vim.ui.select(vim.tbl_keys(case_modes), {
    prompt = 'case',
  }, function(c_mode)
    if c_mode then
      case_mode = case_modes[c_mode]
      vim.ui.select(vim.tbl_keys(filters), {
        prompt = 'filters',
      }, function(f_mode)
        if f_mode then
          local f = filters[f_mode]
          if type(f) == 'table' then
            filter = table.concat(f, ' ')
          else
            filter = f
          end
          command = command .. ' ' .. case_mode .. ' ' .. filter
          vim.ui.input({ prompt = 'pattern', default = '' }, function(input)
            if not input then
              return
            end
            spawn_rg(command, input)
          end)
        end
      end)
    end
  end)
end

vim.api.nvim_create_user_command('Rg', function(a)
  spawn_rg(rg_cmd, a.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('RgH', function(a)
  spawn_rg(rg_cmd_H, a.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('RgI', function(a)
  spawn_rg(rg_cmd_I, a.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('RgHI', function(a)
  spawn_rg(rg_cmd_HI, a.args)
end, { nargs = '+' })

vim.keymap.set('n', '<M-S-f>', function()
  M.rg()
end)

return M
