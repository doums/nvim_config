-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- plugin to search patterns using ripgrep

local M = {}

local qf = require('plugins.qf')
local lvl = vim.log.levels
local rg_root_cmd = 'rg --vimgrep'

local _mt = {}
local _flags = {
  hidden = { l = 'hidden', s = 'H' },
  no_ignore = { l = 'no-ignore', s = 'I' },
  case_sensitive = { l = 'case-sensitive', s = 's' },
  ignore_case = { l = 'ignore-case', s = 'i' },
  smart_case = { l = 'smart-case', s = 'S' },
}

-- metamethod to index flags by `s` value
function _mt:__index(flag)
  for _, f in next, self do
    if f.s == flag then
      return f
    end
  end
end
local rg_flags = setmetatable(_flags, _mt)

local jobs = {}

local function get_job(id)
  local job = jobs[id]
  if not job then
    vim.notify(string.format(' ✕ rg job not found %s', id), lvl.WARN)
  end
  return job or {}
end

local function on_exit(id, code)
  local job = get_job(id)
  if code == 0 then
    vim.notify(string.format(' ✓ %d match', job.match or 0), lvl.INFO)
  elseif code == 1 then
    vim.notify(string.format(' ◌ no match', code), lvl.INFO)
  else
    vim.notify(string.format(' ✕ rg failed [%d]', code), lvl.ERROR)
  end
  jobs[id] = nil
end

local function on_event(id, data, event)
  if event ~= 'stdout' then
    return
  end
  table.remove(data) -- remove eof item
  local job = get_job(id)
  job.match = #data
  if vim.tbl_isempty(data) then
    return
  end
  vim.fn.setqflist({}, 'r', {
    title = 'rg ' .. table.concat(job.flags or {}, ''),
    lines = data,
    -- quickfixtextfunc = qf.qf_format,
  })
  vim.cmd('copen')
end

local function build_cmd(flags)
  local command = rg_root_cmd
  for _, f in ipairs(flags) do
    local flag = rg_flags[f]
    if flag then
      command = command .. ' --' .. flag.l
    else
      vim.notify(string.format('[rg] unknown flag `%s`', f), lvl.WARN)
    end
  end
  return command
end

function M.rg(pattern, flags, path)
  local command = build_cmd(flags) .. ' ' .. pattern
  if path then
    command = command .. ' ' .. path
  end
  vim.notify(string.format('running [%s]', command), lvl.DEBUG)
  local job_id = vim.fn.jobstart(command, {
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
  jobs[job_id] = { command = command, pattern = pattern, flags = flags }
end

local case_modes = {
  ['default'] = {},
  ['smart'] = { 'S' },
  ['sensitive'] = { 's' },
  ['ignore'] = { 'i' },
}

local filters = {
  ['default'] = {},
  ['hidden'] = { 'H' },
  ['no ignore'] = { 'I' },
  ['both'] = { 'H', 'I' },
}
function M.rgui(path)
  vim.ui.select({ 'default', 'smart', 'sensitive', 'ignore' }, {
    prompt = 'case',
  }, function(c_mode)
    if not c_mode then
      return
    end
    vim.ui.select({ 'default', 'hidden', 'no ignore', 'both' }, {
      prompt = 'filters',
    }, function(f_mode)
      if not f_mode then
        return
      end
      vim.ui.input({ prompt = 'pattern', default = '' }, function(pattern)
        if not pattern then
          return
        end
        M.rg(
          pattern,
          vim.tbl_flatten({ case_modes[c_mode], filters[f_mode] }),
          path
        )
      end)
    end)
  end)
end

local function str_to_list(str)
  local t = {}
  str:gsub('.', function(c)
    table.insert(t, c)
  end)
  return t
end

vim.api.nvim_create_user_command('Rg', function(a)
  local pattern
  local path
  local flags = {}
  -- args are expected to be something like
  -- [flags] pattern [path]
  local last = table.remove(a.fargs)
  -- if last item is a valid fs path, then the pattern is the
  -- second item from the end of the args list
  if vim.loop.fs_stat(last) and #a.fargs > 0 then
    path = last
    pattern = table.remove(a.fargs)
  else
    pattern = last
  end
  for _, f in ipairs(a.fargs) do
    if #f > 1 then
      for _, v in ipairs(str_to_list(f)) do
        table.insert(flags, v)
      end
    else
      table.insert(flags, f)
    end
  end
  M.rg(pattern, flags, path)
end, {
  nargs = '+',
})

return M
