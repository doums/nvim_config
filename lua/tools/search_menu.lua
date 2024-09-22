-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Menu wrapping Telescope find_files and live_grep pickers

local M = {}

local _fd_cmd = { 'fd', '-t', 'f', '--strip-cwd-prefix' }
local fd_flags = {
  H = '--hidden',
  h = '--hidden', -- alias for '--hidden' and globs excluded files
  I = '--no-ignore',
  u = '--unrestricted', -- alias for '--hidden --no-ignore'
  s = '--case-sensitive',
  i = '--ignore-case',
  e = '', -- add globs excluded files
}
local rg_flags = {
  H = '--hidden',
  h = '--hidden',
  I = '--no-ignore',
  u = { '--hidden', '--no-ignore' },
  S = '--smart-case',
  s = '--case-sensitive',
  i = '--ignore-case',
  e = '',
}
local cfg = {
  flag_list = { fd = 'HhIusie', rg = 'HhIuSsie' },
  flag_map = { fd = fd_flags, rg = rg_flags },
  excluded_files = {
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
  },
}

local function get_excluded_flags(cmd)
  if cmd == 'rg' then
    return vim
      .iter(cfg.excluded_files.rg)
      :map(function(file)
        return '-g!' .. file
      end)
      :totable()
  end
  if cmd == 'fd' then
    return vim
      .iter(cfg.excluded_files.fd)
      :map(function(file)
        return '-E' .. file
      end)
      :totable()
  end
end

local function parse_flags(flags, flag_map, cmd)
  return vim
    .iter(flags)
    :map(function(flag)
      if not flag_map[flag] then
        error(flag, 0)
        return nil
      end
      if flag == 'h' then
        return { flag_map[flag], get_excluded_flags(cmd) }
      end
      if flag == 'e' then
        return get_excluded_flags(cmd)
      end
      return flag_map[flag]
    end)
    :flatten(2)
    :totable()
end

function M.search(args)
  args = args or { cmd = 'rg', picker_opts = {} }
  local cmd = args.cmd
  local picker_opts = args.picker_opts

  if not cmd or (cmd ~= 'rg' and cmd ~= 'fd') then
    vim.notify(
      ' ✕ wrong command, expected one of `rg` or `fd`',
      vim.log.levels.ERROR
    )
    return
  end

  local search_fn
  if cmd == 'rg' then
    search_fn = require('telescope.builtin').live_grep
  else
    search_fn = require('telescope.builtin').find_files
  end

  vim.ui.input(
    { prompt = string.format('%s (%s)', cmd, cfg.flag_list[cmd]) },
    function(input)
      local s, trimed = pcall(vim.trim, input)
      if s then
        input = trimed
      end
      if not input then
        return
      end
      if input == '' then
        search_fn(vim.tbl_extend('force', picker_opts, {
          find_command = cmd == 'fd' and _fd_cmd or nil,
          prompt_prefix = cmd .. '> ',
        }))
        return
      end
      local input_flags = vim.split(input, '')
      local s, p_flags = pcall(parse_flags, input_flags, cfg.flag_map[cmd], cmd)
      if not s then
        vim.notify(
          string.format(
            ' ✕ unknown flags "%s", expected [%s]',
            p_flags,
            cfg.flag_list[cmd]
          ),
          vim.log.levels.ERROR
        )
        return nil
      end
      print(' flags → ' .. vim.iter(p_flags):join(' '))
      local opts = {
        prompt_prefix = string.format('%s %s> ', cmd, input),
      }
      if cmd == 'fd' then
        opts.find_command = vim.list_extend(vim.deepcopy(_fd_cmd), p_flags)
      else
        opts.additional_args = p_flags
      end
      search_fn(vim.tbl_extend('force', picker_opts, opts))
    end
  )
end

return M
