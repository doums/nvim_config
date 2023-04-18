-- ┎┈┄┄┈─────────┒
-- ┃ MAIN CONFIG ┃
-- ┖─────────┈┄┄┈┚

-- pierreD

-- enables the experimental Lua module loader
vim.loader.enable()

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- map leader
vim.g.mapleader = ','

-- OPTIONS
local o = vim.o
local opt = vim.opt

o.termguicolors = true
o.number = true
o.relativenumber = true
o.showmode = false
o.shortmess = 'IFaWcs'
o.ignorecase = true
o.smartcase = true
o.cindent = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.showmatch = true
o.matchtime = 3
o.updatetime = 100
o.splitbelow = true
o.splitright = true
o.hidden = true
o.cursorline = true
o.cursorlineopt = 'number,screenline'
o.switchbuf = 'usetab'
o.scrolloff = 1
o.completeopt = 'menuone,noselect'
o.pumheight = 10
o.fillchars =
  'diff: ,fold: ,eob: ,vert: ,horiz: ,lastline:•,fold: ,foldsep: ,foldopen:⌄,foldclose:›'
o.clipboard = 'unnamedplus'
o.signcolumn = 'yes:2'
o.cmdheight = 2
o.mouse = 'a'
o.statusline = ' ' -- hide the default statusline on the first frames
o.laststatus = 3
o.guicursor = 'a:block-Caret'
o.spelllang = 'en_us'
o.spelloptions = 'camel'
o.colorcolumn = '66'
o.textwidth = 66
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldlevelstart = 99
o.splitkeep = 'screen'
opt.complete = opt.complete:append({ 'i' })
opt.formatoptions = opt.formatoptions:append('lv')
o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
o.grepformat = '%f:%l:%c:%m'

-- load core keymaps
require('keymaps')

-- load autocmds
require('autocmds')

-- Miscellaneous
-- nvim as man pager
vim.cmd('runtime ftplugin/man.vim')
-- disable EditorConfig support
vim.g.editorconfig = false

-- generate custom highlight groups
require('hl').hl()

-- load custom filetypes
require('filetypes.dotenv')
require('filetypes.pkgbuild')

-- load plugins ⚡
require('lazy').setup('plugins', {
  dev = {
    path = '~/.local/share/nvim/dev',
    fallback = true, -- fallback to git when local plugin doesn't exist
  },
})

-- colorscheme
vim.cmd('colorscheme espresso')

-- LSP config
require('lsp')
