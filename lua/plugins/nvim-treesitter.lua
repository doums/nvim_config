-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    {
      'windwp/nvim-ts-autotag',
      ft = {
        'javascriptreact',
        'typescriptreact',
        'jsx',
        'tsx',
        'markdown',
        'html',
      },
    },
  },
}

P.config = function()
  local install = require('nvim-treesitter.install')
  local setup = require('nvim-treesitter.configs').setup

  if _G.os_name == 'windows' then
    -- see https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
    install.compilers = { 'zig' }
    install.prefer_git = false
  end

  setup({
    ensure_installed = {
      'c',
      'cpp',
      'rust',
      'yaml',
      'bash',
      'fish',
      'typescript',
      'javascript',
      'html',
      'css',
      'lua',
      'comment',
      'markdown',
      'jsdoc',
      'tsx',
      'toml',
      'json',
      'jsonc',
      'vimdoc',
    },
    -- TODO on Windows async install is not working for some reason
    sync_install = _G.os_name == 'windows',
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 't',
        node_incremental = '<A-l>',
        scope_incremental = '<A-j>',
        node_decremental = '<A-h>',
      },
    },
    autotag = {
      enable = true,
      filetypes = {
        'html',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'jsx',
        'tsx',
        'markdown',
      },
    },
    -- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
        },
        include_surrounding_whitespace = true,
      },
    },
  })
end

return P
