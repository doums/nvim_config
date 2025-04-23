-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local _flags = {
  'H', -- hidden files
  'h', -- alias for hidden and globs excluded files
  'I', -- ignored files
  'u', -- hidden and ignored files
  'S', -- smart case
  's', -- case sensitive
  'i', -- ignore case
  'e', -- add globs excluded files
}
local _case_flags = {
  sensitive = '--case-sensitive',
  ignore = '--ignore-case',
  smart = '--smart-case',
}
local _pickers = {
  rg = { picker = 'grep', cmd = 'rg' },
  fd = { picker = 'files', cmd = 'fd' },
}
local excluded = {
  rg = {
    '.idea',
    'node_modules',
    '.git',
    'target',
    'package-lock.json',
    'Cargo.lock',
  },
  fd = {
    '.idea',
    'node_modules',
    '.git',
    'target',
  },
}

local function check_input(input)
  vim.iter(input):each(function(f)
    if not vim.list_contains(_flags, f) then
      vim.notify(string.format('[%s] unknown flag', f), vim.log.levels.WARN)
    end
  end)
end

local function get_excluded_flags(cmd)
  if cmd == 'rg' then
    return vim
      .iter(excluded.rg)
      :map(function(file)
        return '-g!' .. file
      end)
      :totable()
  end
  if cmd == 'fd' then
    return vim
      .iter(excluded.fd)
      :map(function(file)
        return '-E' .. file
      end)
      :totable()
  end
end

local function get_case_flag(flags, cmd)
  if vim.iter(flags):any(function(f)
    return f == 's'
  end) then
    return _case_flags.sensitive
  end
  if vim.iter(flags):any(function(f)
    return f == 'i'
  end) then
    return _case_flags.ignore
  end
  -- for `fd` smart case is the default
  if cmd == 'fd' then
    return nil
  end
  if vim.iter(flags):any(function(f)
    return f == 'S'
  end) then
    return _case_flags.smart
  end
  return nil
end

local function parse_flags(flags, cmd)
  local additional = {}
  local hidden = vim.iter(flags):any(function(f)
    return f == 'H' or f == 'h' or f == 'u'
  end)
  local ignored = vim.iter(flags):any(function(f)
    return f == 'I' or f == 'u'
  end)
  if vim.iter(flags):any(function(f)
    return f == 'e' or f == 'h'
  end) then
    table.insert(additional, get_excluded_flags(cmd))
  end
  local case_flag = get_case_flag(flags, cmd)
  if case_flag then
    table.insert(additional, case_flag)
  end
  additional = vim.iter(additional):flatten():totable()

  return {
    hidden = hidden,
    ignored = ignored,
    args = additional,
  }
end

local function pick(opts, cmd)
  local picker = _pickers[cmd]
  opts = vim.tbl_extend(
    'error',
    -- set live mode to enable additional args to be used by the
    -- picker
    { cmd = picker.cmd, title = picker.cmd, live = true },
    opts
  )
  print(
    string.format(
      '→ [%s] H:%s I:%s %s',
      cmd,
      opts.hidden,
      opts.ignored,
      vim.iter(opts.args):join(' ')
    )
  )
  Snacks.picker[picker.picker](opts)
end

function M.search(args)
  args = args or { cmd = 'rg' }
  local cmd = args.cmd

  if not cmd or (cmd ~= 'rg' and cmd ~= 'fd') then
    vim.notify('wrong cmd, expected one of `rg` | `fd`', vim.log.levels.ERROR)
    return
  end

  vim.ui.input(
    { prompt = string.format('%s (%s)', cmd, vim.iter(_flags):join('')) },
    function(input)
      local s, trimed = pcall(vim.trim, input)
      if s then
        input = trimed
      end
      if not input then
        return
      end
      local flags = vim.split(input, '')
      check_input(flags)
      local res = parse_flags(flags, cmd)
      pick(res, cmd)
    end
  )
end

return M
