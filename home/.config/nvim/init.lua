-- based on https://github.com/rafaeldelboni/cajus-nfnl

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print("nvim is bootstrapping.")
  local fn = vim.fn

  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)
vim.loader.enable()

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- seting laststatus before load plugins
-- see https://www.reddit.com/r/neovim/comments/1clx1cu
vim.go.laststatus = 3

require("lazy").setup("plugins")
