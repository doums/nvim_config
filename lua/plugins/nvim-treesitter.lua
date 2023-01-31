-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Config for nvim-treesitter

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'cpp',
    'rust',
    'yaml',
    'bash',
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
    'graphql',
    'jsonc',
  },
  highlight = { enable = true, custom_captures = { todo = 'Todo' } },
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
    filetypes = { 'typescriptreact', 'tsx', 'markdown' },
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
