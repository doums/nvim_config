local P = {
  'saecki/crates.nvim',
  -- event = { 'BufRead Cargo.toml' },
  dependencies = { 'nvim-lua/plenary.nvim' },
}

P.config = function()
  require('crates').setup({
    lsp = {
      enabled = true,
      actions = true,
      completion = false,
      hover = true,
    },
    text = {
      loading = '  ◔ Loading',
      version = '  ✓ %s',
      prerelease = '  ! %s',
      yanked = '  ⊖ %s',
      nomatch = '  � No match',
      upgrade = '  ↑ %s',
      error = '  ✕ Error fetching crate',
    },
  })
end

return P
