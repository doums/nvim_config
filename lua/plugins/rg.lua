local P = {
  'doums/rg.nvim',
  cmd = { 'Rg', 'Rgf', 'Rgp', 'Rgfp' },
  -- dev = true,
}

P.opts = {
  qf_format = require('tools.qf').qf_format,
}

return P
