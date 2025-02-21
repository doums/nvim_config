-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

-- Config for LSP servers and diagnostics

local qf = require('tools.qf')

local signature_help_cfg = {
  bind = true,
  doc_lines = 2,
  floating_window = false,
  hint_enable = true,
  hint_prefix = '→ ',
  hint_scheme = 'LspInlayHint',
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
local d_sign = '╸'
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  signs = {
    severity = { min = vim.diagnostic.severity.INFO },
    text = {
      [vim.diagnostic.severity.ERROR] = d_sign,
      [vim.diagnostic.severity.WARN] = d_sign,
      [vim.diagnostic.severity.INFO] = d_sign,
      [vim.diagnostic.severity.HINT] = d_sign,
    },
  },
  float = {
    header = '',
    format = format_diagnostic,
    prefix = prefix_diagnostic,
  },
})

local notified_clients = {}

vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    vim.notify('⭘ ' .. client.name, vim.log.levels.INFO)
    notified_clients[client.id] = nil
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    local bufopt = { buffer = args.buf }

    if not notified_clients[client.id] then
      vim.notify('󰣪 ' .. client.name, vim.log.levels.INFO)
      notified_clients[client.id] = 1
    end

    -- keybinds
    -- open lsp menu
    vim.keymap.set(
      { 'n', 'v' },
      '<A-CR>',
      require('tools.lsp_menu').open,
      bufopt
    )
    -- goto definition
    vim.keymap.set('n', '<A-b>', function()
      vim.lsp.buf.definition({ on_list = qf.on_qf_list })
    end, bufopt)
    -- find usages
    vim.keymap.set('n', '<A-u>', function()
      vim.lsp.buf.references(nil, { on_list = qf.on_qf_list })
    end, bufopt)
    vim.keymap.set(
      'n',
      '<A-a>',
      '<cmd>lua vim.diagnostic.jump({count=-1,float=false})<CR>',
      bufopt
    )
    vim.keymap.set(
      'n',
      '<A-z>',
      '<cmd>lua vim.diagnostic.jump({count=1,float=false})<CR>',
      bufopt
    )
    vim.keymap.set('n', '<A-d>', vim.lsp.buf.hover, bufopt)
    -- refactor
    vim.keymap.set('n', '<A-r>', vim.lsp.buf.rename, bufopt)
    -- open a floating window with the diagnostics from the current cursor position
    vim.api.nvim_create_autocmd('CursorHold', {
      callback = function()
        vim.diagnostic.open_float({
          focusable = false,
          scope = 'cursor',
          severity = { min = vim.diagnostic.severity.INFO },
        })
      end,
      buffer = args.buf,
    })
    -- highlight the symbol under the cursor
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        callback = function()
          vim.lsp.buf.document_highlight()
        end,
        buffer = args.buf,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        callback = function()
          vim.lsp.buf.clear_references()
        end,
        buffer = args.buf,
      })
    end

    -- inlay hints support
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })

      vim.keymap.set('n', '<A-i>', function()
        local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
        vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = args.buf })
      end, bufopt)
    end

    require('lsp_signature').on_attach(signature_help_cfg, args.buf)

    -- TODO disable semantic highlighting
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
