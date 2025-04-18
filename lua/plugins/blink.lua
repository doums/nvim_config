-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'saghen/blink.cmp',
  dependencies = {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
  },
  version = '1.*',
  event = { 'InsertEnter', 'LspAttach', 'CmdlineEnter' },
}

local source_shorts = {
  lsp = 'lsp',
  path = 'path',
  snippets = 'snip',
  buffer = 'buf',
}

-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#completionItemKind
local kind_shorts = {
  ['Text'] = 'txt',
  ['Method'] = 'Fn',
  ['Function'] = 'Fn',
  ['Constructor'] = 'Ctor',
  ['Field'] = 'Field',
  ['Variable'] = 'Var',
  ['Class'] = 'Class',
  ['Interface'] = 'Iface',
  ['Module'] = 'Mod',
  ['Property'] = 'Prop',
  ['Unit'] = 'Unit',
  ['Value'] = 'Val',
  ['Enum'] = 'Enum',
  ['Keyword'] = 'KeyW',
  ['Snippet'] = '~',
  ['Color'] = 'Color',
  ['File'] = 'File',
  ['Reference'] = 'Ref',
  ['Folder'] = 'Folder',
  ['EnumMember'] = 'Enum',
  ['Constant'] = 'Const',
  ['Struct'] = 'Struct',
  ['Event'] = 'Event',
  ['Operator'] = 'Op',
  ['TypeParameter'] = 'Type',
}

local function fmt_lsp_sources(ctx)
  return source_shorts[ctx.source_id] or ctx.source_id
end

local function fmt_lsp_kind(ctx)
  return kind_shorts[ctx.kind] or ctx.kind
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
    default = { 'lsp', 'path', 'snippets', 'buffer' },
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
          { 'kind', gap = 1, 'source_id' },
        },
        components = {
          label = { width = { fill = true, max = 52 } },
          kind = { text = fmt_lsp_kind },
          source_id = { text = fmt_lsp_sources },
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
  snippets = { preset = 'luasnip' },
  fuzzy = {
    implementation = 'prefer_rust_with_warning',
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },
  signature = {
    enabled = true,
    window = {
      min_width = 1,
      max_width = 66,
      max_height = 4,
      border = _G._pdcfg.win_border,
      scrollbar = false,
      treesitter_highlighting = false,
      show_documentation = false,
    },
  },
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
