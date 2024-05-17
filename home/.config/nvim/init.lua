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

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
    {
      "folke/lazy.nvim",
      version = "*"
    },
    {
      "Olical/nfnl",
      ft = "fennel",
      dependencies = { "norcalli/nvim.lua" },
      init = function()
        require("config")
      end
    }
  })

