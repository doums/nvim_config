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

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.del('n', '<C-k>', { buffer = bufnr })
  vim.keymap.del('n', '<C-e>', { buffer = bufnr })
  vim.keymap.del('n', 'f', { buffer = bufnr })
  vim.keymap.del('n', 'q', { buffer = bufnr })

  vim.keymap.set(
    'n',
    '<C-s>',
    api.node.open.horizontal,
    opts('Open: Horizontal Split')
  )
  vim.keymap.set('n', '<C-d>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', '<A-f>', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', '<C-q>', api.tree.close, opts('Close'))
  vim.keymap.set('n', '<C-f>', function()
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
    trash = {
      cmd = 'trashy',
    },
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
      hidden_display = function(hidden_stats)
        local total_count = 0
        for _, count in pairs(hidden_stats) do
          total_count = total_count + count
        end

        if total_count > 0 then
          return '󰈉 ' .. tostring(total_count)
        end
        return nil
      end,
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
      preserve_window_proportions = false,
    },
  })
end

return P
