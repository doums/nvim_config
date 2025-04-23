-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
}

local source_shorts = {
  path = 'path',
  buffer = 'buf',
}

local function fmt_sources(ctx)
  return source_shorts[ctx.source_id] or ctx.source_id
end

P.opts = {
  keymap = {
    -- https://cmp.saghen.dev/configuration/keymap.html#default
    preset = 'none',
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'cancel' },
    ['<CR>'] = { 'select_and_accept', 'fallback' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<C-d>'] = { 'show_documentation', 'hide_documentation' },
    ['<C-p>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-o>'] = { 'scroll_documentation_down', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  sources = {
    default = { 'path', 'buffer' },
    -- path completion relative to cwd
    -- https://cmp.saghen.dev/recipes.html#path-completion-from-cwd-instead-of-current-buffer-s-directory
    providers = {
      path = {
        opts = {
          get_cwd = function(_)
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
  completion = {
    -- 'balth_|_azar' - prefix: will match 'balth_' - full: match 'balth__azar'
    keyword = { range = 'full' },
    list = { selection = { preselect = true, auto_insert = true } },
    accept = { auto_brackets = { enabled = true } },
    menu = {
      auto_show = true,
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'source_id' },
        },
        components = {
          label = { width = { fill = true, max = 48 } },
          label_description = { width = { max = 20 } },
          source_id = { text = fmt_sources },
        },
      },
      border = 'none',
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        max_width = 66,
        border = _G._pdcfg.win_border,
      },
    },
  },
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },
  signature = { enabled = false },
  cmdline = {
    -- https://cmp.saghen.dev/modes/cmdline.html
    keymap = {
      preset = 'none',
      ['<Tab>'] = { 'show_and_insert', 'select_next' },
      ['<S-Tab>'] = { 'show_and_insert', 'select_prev' },
      ['<C-space>'] = { 'show', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-CR>'] = { 'select_and_accept' },
      ['<C-e>'] = { 'cancel' },
    },
    completion = {
      menu = {
        draw = {
          columns = {
            { 'label', 'label_description' },
          },
        },
      },
    },
  },
}

P.opts_extend = { 'sources.default' }

return P
