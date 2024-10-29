-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = 'ö'

vim.o.timeout = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.wrap = false
vim.o.foldenable = false
vim.o.number = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmode = false
vim.o.showcmd = false

-- Display whitespaces as nice unicode chars
vim.o.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  extends = '↷',
  precedes = '↶',
  nbsp = '█',
}

-- Enable g by default on substitute - that is, all matches in line are
-- replaced. use s///g to substitute only first match.
-- NOTE: Not sure if this is a good idea?
vim.o.gdefault = true

-- Shorten file messages:
-- m [Modiefied] -> [+], r [readonly] -> [RO], I no welcome message
-- c no match x of y for completion
vim.opt.shortmess:append({
  m = true,
  r = true,
  I = true,
  c = true
})
-- Command completion. Complete till longest common string and show wildmenu.
vim.opt.wildmode = { "longest", "full" }
-- Ignorecase when completing filenames on command prompt. e.g. ~/.xres -> ~/.Xresources
vim.o.wildignorecase = true
-- Disable text and comment wrapping
vim.opt.formatoptions:remove({ "t", "c" })

-- Save vim undo history to file, so history persists through sessions
vim.o.undofile = true
vim.o.undodir = '~/.cache/vim/undo'
vim.opt.completeopt = { 'noinsert', 'menuone', 'noselect' }
vim.opt.signcolumn = 'yes:1'

-- Terminal
vim.o.scrollback = 50000

-- Disable mouse
vim.o.mouse = ''

-- Read project .nvim.lua / .nvimrc / .exrc
vim.o.exrc = true
vim.o.termguicolors = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  diff = {
    cmd = 'diffview.nvim',
  }
})

vim.cmd 'source ~/.vim/config.vim'

require('config/keymaps')
require('config/quickfix')

-- TODO: cpr or <leader>r on lua files (~/.vim/lua/) to run:
-- package.loaded(path) = nil & require(path)
