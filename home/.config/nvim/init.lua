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

-- Set up core plugins, Lazy and nfnl
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
-- Any lua file in ~/.config/nvim/lua/plugins/*.lua will be automatically 
--   merged in the main plugin spec
require("lazy").setup("plugins")
