local M = {}

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

function M.setup()
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
end

return M
