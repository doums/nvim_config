-- Define a custom filetype for PKGBUILD files

vim.filetype.add({
  filename = {
    ['PKGBUILD'] = 'pkgbuild',
  },
  pattern = {
    ['PKGBUILD.*'] = 'pkgbuild',
  },
})
