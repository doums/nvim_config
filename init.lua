-- ┎┈┄┄┈─────────┒
-- ┃ MAIN CONFIG ┃
-- ┖─────────┈┄┄┈┚

-- pierreD

_G._pdcfg = {
  os = jit.os:lower(),
  lt_lang = 'en-US',
  win_border = { '', '', '', ' ', '', '', '', ' ' },
  terminal_bg = '#171717',
}

-- enables the experimental Lua module loader
vim.loader.enable()

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable', -- latest stable release
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- map leader
vim.g.mapleader = ','

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- init clipboard OSC52
require('cb').osc52()

-- OPTIONS
local o = vim.o

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
o.completeopt = 'menu,menuone,noinsert'
o.pumheight = 10
o.fillchars =
  'diff: ,fold: ,eob: ,vert: ,horiz: ,lastline:•,fold: ,foldsep: ,foldopen:⌄,foldclose:›'
o.clipboard = 'unnamedplus'
o.signcolumn = 'yes:2'
o.cmdheight = 2
o.mouse = 'a'
o.laststatus = 3
o.spelllang = 'en_us'
o.spelloptions = 'camel'
o.colorcolumn = '66'
o.textwidth = 66
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
o.foldlevelstart = 99
o.splitkeep = 'screen'
o.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
o.grepformat = '%f:%l:%c:%m'
o.mousemodel = 'extend'
o.conceallevel = 0
o.winborder = 'none'
o.sidescroll = 2
vim.opt.complete:append({ 'i' })
vim.opt.formatoptions:append('lv')
vim.opt.listchars:append({ conceal = '•', precedes = '<', extends = '>' })
vim.opt.guicursor = {
  'a:block-Cursor',
  'i-c-ci-t:hor20',
  'r-cr:hor20-rCursor',
  'o:block-oCursor',
}

-- core mapping
require('keymaps')

-- load autocmds
require('autocmds')

-- misc
-- disable EditorConfig support
vim.g.editorconfig = false

-- load plugins ⚡
require('lazy').setup('plugins', {
  dev = {
    path = vim.fn.stdpath('data') .. '/dev',
    fallback = true, -- fallback to git when local plugin doesn't exist
  },
})

-- colorscheme
vim.cmd.colorscheme('dark')
