local P = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
}

P.opts = {
  disable_filetype = { 'snacks_picker_input', 'spectre_panel', 'suitui' },
}

return P
