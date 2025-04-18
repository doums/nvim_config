-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

local qf = require('tools.qf')

local notified_clients = {}

function M.setup()
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
      vim.keymap.set('n', '<A-d>', function()
        vim.lsp.buf.hover({ border = _G._pdcfg.win_border })
      end, bufopt)
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

      -- use LSP for folding
      if client:supports_method('textDocument/foldingRange') then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
      end

      -- TODO disable semantic highlighting
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  })

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
end

return M
