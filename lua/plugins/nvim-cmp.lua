-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local P = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
  },
  event = { 'InsertEnter', 'LspAttach', 'CmdlineEnter' },
}

local api = vim.api

P.config = function()
  local cmp = require('cmp')
  local ls = require('luasnip')
  local ap = require('nvim-autopairs.completion.cmp')

  local function has_word_before()
    local line, col = unpack(api.nvim_win_get_cursor(0))
    return col ~= 0
      and api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match('%s')
        == nil
  end

  local tab_key = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif ls.expand_or_locally_jumpable() then
      ls.expand_or_jump()
    elseif has_word_before() then
      cmp.complete()
    else
      fallback()
    end
  end, {
    'i',
    's',
  })

  local stab_key = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif ls.jumpable(-1) then
      ls.jump(-1)
    else
      fallback()
    end
  end, {
    'i',
    'c',
    's',
  })

  -- insert `(` after select function or method item
  cmp.event:on('confirm_done', ap.on_confirm_done())

  -- hide copilot suggestions when completion menu is open
  -- cmp.event:on('menu_opened', function()
  --   vim.b.copilot_suggestion_hidden = true
  -- end)
  -- cmp.event:on('menu_closed', function()
  --   vim.b.copilot_suggestion_hidden = false
  -- end)

  cmp.setup({
    mapping = {
      ['<tab>'] = tab_key,
      ['<S-tab>'] = stab_key,
      ['<Down>'] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        { 'i' }
      ),
      ['<Up>'] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        { 'i' }
      ),
      ['<M-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<M-o>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Safely select entries
      -- if nothing is selected (including preselections) add a newline as usual
      -- if something has explicitly been selected by the user, select it
      -- see https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
      ['<CR>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
      }),
      -- toggle documentation window
      ['<M-d>'] = function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.open_docs()
        end
      end,
    },
    snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'buffer' },
    },
    cmp.setup.filetype('suitui', {
      sources = {
        { name = 'path' },
      },
    }),
    window = {
      completion = { border = nil },
      documentation = {
        border = { '', '', '', ' ', '', '', '', ' ' },
        -- fix highlight issues inside documentation window
        winhighlight = 'FloatBorder:NormalFloat,Normal:NormalFloat,Error:Fg',
      },
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          buffer = '⌈buf⌋',
          nvim_lsp = '⌈lsp⌋',
          luasnip = '⌈snip⌋',
          nvim_lua = '⌈lua⌋',
          path = '⌈path⌋',
        })[entry.source.name]
        return vim_item
      end,
    },
  })

  -- command line `:`
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
  -- command line `/`
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
end

return P
