-- Define a custom filetype for dotenv files

vim.filetype.add({
  filename = {
    ['.env'] = 'dotenv',
  },
  pattern = {
    ['%.env.*'] = 'dotenv',
  },
})
