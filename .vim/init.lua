-- Ensure Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Set mapleader before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = 'ö'

require('lazy').setup('plugins')

vim.cmd 'source ~/.vim/config.vim'

require('config/quickfix')
