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

P.config = function()
  local cmp = require('cmp')
  local ls = require('luasnip')
  local ap = require('nvim-autopairs.completion.cmp')

  local function has_word_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api
          .nvim_buf_get_lines(0, line - 1, line, true)[1]
          :sub(col, col)
          :match('%s')
        == nil
  end

  local tab_key = cmp.mapping(function(fallback)
    local co = _G.copilot == 'ON' and require('copilot.suggestion')

    if co and co.is_visible() then
      co.accept()
    elseif cmp.visible() then
      cmp.select_next_item()
    elseif ls.expand_or_locally_jumpable() then
      ls.expand_or_jump()
    elseif has_word_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { 'i', 's' })

  local stab_key = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif ls.jumpable(-1) then
      ls.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' })

  local return_key = function(fallback)
    -- if cmp menu is visible insert the selected item or
    -- the first item if no item is selected
    if cmp.visible() then
      cmp.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    else
      fallback()
    end
  end

  local cmd_confirm = function()
    if cmp.visible() then
      -- insert the selected item or the first item if no item
      -- is selected
      cmp.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      })
    else
      -- show completion menu
      cmp.complete()
    end
  end

  -- insert `(` after select function or method item
  cmp.event:on('confirm_done', ap.on_confirm_done())

  -- hide copilot suggestions when completion menu is open
  -- cmp.event:on('menu_opened', function()
  --   vim.b.copilot_suggestion_hidden = true
  -- end)
  -- cmp.event:on('menu_closed', function()
  --   vim.b.copilot_suggestion_hidden = false
  -- end)

  ---@diagnostic disable-next-line: redundant-parameter
  cmp.setup({
    -- ⚠ this is required to automatically select the first item
    -- in suggestion list
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = {
      ['<tab>'] = tab_key,
      ['<S-tab>'] = stab_key,
      ['<Down>'] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        { 'i', 'c' }
      ),
      ['<Up>'] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        { 'i', 'c' }
      ),
      ['<M-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<M-o>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-space>'] = cmp.mapping({
        i = cmp.mapping.complete(),
        c = cmd_confirm,
      }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping({
        i = return_key,
        s = cmp.mapping.confirm({ select = true }),
      }),
      ['<C-CR>'] = cmp.mapping(cmd_confirm, { 'c' }),
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
      { name = 'crates' },
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
          crates = '⌈crates⌋',
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
