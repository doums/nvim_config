-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'nvim-tree/nvim-tree.lua',
  -- do not lazy load as recommended
  -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Installation#lazy-loading
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'doums/rg.nvim',
  },
}

local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local rgui = require('rg').rgui
  local km = vim.keymap

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  km.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  km.set('n', '<C-d>', api.node.show_info_popup, opts('Info'))
  km.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  km.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  km.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  km.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  km.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  km.set('n', '<CR>', api.node.open.edit, opts('Open'))
  km.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  km.set('n', '.', api.node.run.cmd, opts('Run Command'))
  km.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  km.set('n', 'a', api.fs.create, opts('Create'))
  km.set('n', 'c', api.fs.copy.node, opts('Copy'))
  km.set('n', 'd', api.fs.remove, opts('Delete'))
  km.set('n', '<A-f>', api.live_filter.start, opts('Filter'))
  km.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  km.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  km.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  km.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  km.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  km.set('n', 'o', api.node.open.edit, opts('Open'))
  km.set('n', 'p', api.fs.paste, opts('Paste'))
  km.set('n', '<C-q>', api.tree.close, opts('Close'))
  km.set('n', 'r', api.fs.rename, opts('Rename'))
  km.set('n', 'R', api.tree.reload, opts('Refresh'))
  km.set('n', 'x', api.fs.cut, opts('Cut'))
  km.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  km.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  km.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  km.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))

  km.set('n', '<C-f>', function()
    local node = api.tree.get_node_under_cursor()
    rgui(node.absolute_path)
  end, opts(''))
end

P.config = function()
  vim.keymap.set('n', '<Tab>', '<cmd>NvimTreeToggle<CR>', { silent = true })
  vim.keymap.set('n', '<S-Tab>', '<cmd>NvimTreeFindFile<CR>', { silent = true })

  require('nvim-tree').setup({
    on_attach = on_attach,
    hijack_cursor = true,
    disable_netrw = true,
    hijack_netrw = true,
    select_prompts = true,
    diagnostics = {
      enable = true,
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = ' ',
        info = ' ',
        warning = ' ',
        error = '╸',
      },
    },
    git = {
      enable = true,
    },
    filters = {
      git_ignored = false,
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    actions = {
      open_file = {
        resize_window = false,
        window_picker = {
          chars = 'HLJKFQDS',
        },
      },
      file_popup = {
        open_win_config = {
          border = 'none',
        },
      },
    },
    live_filter = {
      prefix = '󰈲 ',
      always_show_folders = true,
    },
    renderer = {
      highlight_git = 'name',
      highlight_diagnostics = 'none',
      highlight_modified = 'none',
      highlight_clipboard = 'name',
      icons = {
        symlink_arrow = ' → ',
        diagnostics_placement = 'after',
        show = {
          git = false,
          folder = true,
          file = true,
          folder_arrow = false,
          modified = true,
          diagnostics = true,
        },
        glyphs = {
          default = '󰧮',
          symlink = '󰌹',
          modified = '󰷉',
          folder = {
            arrow_closed = '▶',
            arrow_open = '▼',
            default = '▶',
            open = '▼',
            empty = '▷',
            empty_open = '▽',
            symlink = '󰌹 ',
            symlink_open = '󰌹 ',
          },
        },
      },
    },
    view = {
      width = 40,
      preserve_window_proportions = true,
    },
  })
end

return P
