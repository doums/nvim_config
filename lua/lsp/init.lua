-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Config for LSP

local lsp = vim.lsp
local api = vim.api
local map = vim.keymap.set
local fn = vim.fn

-- Server configs
require('lsp.servers.lua')
require('lsp.servers.c')
require('lsp.servers.rust')
require('lsp.servers.typescript')
require('lsp.servers.null-ls')

local lsp_menu = require('plugins.lsp_menu')
local lsp_spinner = require('lsp_spinner')
local lsp_signature = require('lsp_signature')

lsp_spinner.setup({
  spinner = { '▪', '■', '□', '▫' },
  interval = 80,
  placeholder = ' ',
})

fn.sign_define(
  'DiagnosticSignError',
  { text = '╸', texthl = 'DiagnosticSignError' }
)
fn.sign_define(
  'DiagnosticSignWarn',
  { text = '╸', texthl = 'DiagnosticSignWarn' }
)
fn.sign_define(
  'DiagnosticSignInfo',
  { text = '╸', texthl = 'DiagnosticSignInfo' }
)
fn.sign_define(
  'DiagnosticSignHint',
  { text = '╸', texthl = 'DiagnosticSignHint' }
)

local signature_help_cfg = {
  bind = true,
  doc_lines = 2,
  floating_window = false,
  hint_enable = true,
  hint_prefix = '→ ',
  hint_scheme = 'codeHint',
  hi_parameter = 'Search',
  max_height = 4,
  max_width = 80,
  handler_opts = { border = 'none' },
  padding = ' ',
  toggle_key = '<C-q>',
}

local function format_diagnostic(diagnostic)
  return string.format('%s (%s)', diagnostic.message, diagnostic.source)
end

local function prefix_diagnostic(diagnostic)
  local severity_map = {
    [vim.diagnostic.severity.ERROR] = { '╸ ', 'DiagnosticSignError' },
    [vim.diagnostic.severity.WARN] = { '╸ ', 'WarningSign' },
    [vim.diagnostic.severity.INFO] = { '╸ ', 'InformationSign' },
    [vim.diagnostic.severity.HINT] = { '╸ ', 'HintSign' },
  }
  return unpack(severity_map[diagnostic.severity])
end

-- vim.diagnostic config
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  float = {
    header = false,
    format = format_diagnostic,
    prefix = prefix_diagnostic,
  },
})

local function on_qf_list(options)
  vim.fn.setqflist({}, ' ', options)
  if #options.items > 1 then
    vim.cmd('botright copen 5')
  end
  vim.cmd('cfirst')
end

local function on_ll_list(options, jump_on_first)
  vim.fn.setloclist(0, {}, ' ', options)
  if #options.items > 1 then
    vim.cmd('lopen 5')
  end
  if jump_on_first then
    vim.cmd('lfirst')
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = lsp.get_client_by_id(args.data.client_id)
    local bufopt = { buffer = args.buf }
    -- keybinds
    -- open lsp menu
    map({ 'n', 'v' }, '<A-CR>', lsp_menu, bufopt)
    -- goto definition
    map('n', '<A-b>', function()
      lsp.buf.definition({ on_list = on_qf_list })
    end, bufopt)
    -- find usages
    map('n', '<A-u>', function()
      lsp.buf.references(nil, { on_list = on_qf_list })
    end, bufopt)
    -- current buffer diagnostics
    map('n', '<A-q>', function()
      local list = vim.diagnostic.toqflist(vim.diagnostic.get(args.buf))
      on_ll_list({
        items = list,
        title = '~',
        context = { buf_diagnostics = args.buf },
      })
    end, bufopt)
    -- all buffers diagnostics
    map('n', '<A-S-q>', function()
      local list = vim.diagnostic.toqflist(vim.diagnostic.get(nil))
      on_qf_list({
        items = list,
        title = '≈',
        context = { all_diagnostics = true },
      })
    end, bufopt)
    map(
      'n',
      '<A-a>',
      '<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>',
      bufopt
    )
    map(
      'n',
      '<A-z>',
      '<cmd>lua vim.diagnostic.goto_next({float=false})<CR>',
      bufopt
    )
    map('n', '<A-d>', lsp.buf.hover, bufopt)
    -- refactor
    map('n', '<A-r>', lsp.buf.rename, bufopt)
    map({ 'n', 'v' }, '<A-e>', lsp.buf.format, bufopt)
    -- open a floating window with the diagnostics from the current cursor position
    api.nvim_create_autocmd('CursorHold', {
      callback = function()
        vim.diagnostic.open_float({ focusable = false, scope = 'cursor' })
      end,
      buffer = args.buf,
    })
    -- highlight the symbol under the cursor
    if client.server_capabilities.documentHighlightProvider then
      api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        callback = function()
          lsp.buf.document_highlight()
        end,
        buffer = args.buf,
      })
      api.nvim_create_autocmd('CursorMoved', {
        callback = function()
          lsp.buf.clear_references()
        end,
        buffer = args.buf,
      })
    end
    lsp_spinner.on_attach(client, args.buf)
    lsp_signature.on_attach(signature_help_cfg, args.buf)
  end,
})

local diag_group = vim.api.nvim_create_augroup('lspDiagnosticLiveUpdate', {})

-- live update all buffers diagnostics list in qflist
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = diag_group,
  callback = function(args)
    -- retrieve all normal windows
    local qf = vim.fn.getqflist({ context = true })

    -- if qflist is listing all diagnostics, do update
    if qf.context.all_diagnostics then
      local d = vim.diagnostic.toqflist(vim.diagnostic.get(nil))
      vim.fn.setqflist({}, 'r', { items = d })
    end
  end,
})

-- live update buffer diagnostics in loclists
vim.api.nvim_create_autocmd('DiagnosticChanged', {
  group = diag_group,
  callback = function(args)
    -- retrieve all normal windows
    local wins = vim.tbl_filter(function(win)
      return win.quickfix == 0 and win.loclist == 0
    end, vim.fn.getwininfo())

    -- retrieve corresponding loclist windows for each windows
    local loclists = vim.tbl_map(function(win)
      return vim.fn.getloclist(
        win.winid,
        { context = true, winid = true, title = true }
      )
    end, wins)
    -- only keep the ones with data
    loclists = vim.tbl_filter(function(win)
      return win and win.context.buf_diagnostics
    end, loclists)

    -- update diagnostic lists
    for _, ll in ipairs(loclists) do
      local d =
        vim.diagnostic.toqflist(vim.diagnostic.get(ll.context.buf_diagnostics))

      vim.fn.setloclist(ll.winid, {}, 'r', { items = d })
    end
  end,
})
