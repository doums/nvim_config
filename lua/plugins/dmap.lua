local P = {
  'doums/dmap.nvim',
  event = { 'LspAttach', 'DiagnosticChanged' },
  dev = true,
  enabled = false,
}

P.opts = {
  sources_ignored = { 'cspell' },
  win_align = 'left',
  win_v_offset = 80,
  severity = { min = vim.diagnostic.severity.INFO },
  win_max_height = 10,
}

return P
