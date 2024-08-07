-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.set_keymap("n", "<CR>", ":noh<CR><CR>", {noremap = true})
nvim.set_keymap("n", "<C-w>T", ":tab split<CR>", {noremap = true, silent = true})
nvim.set_keymap("t", "<esc><esc>", "<c-\\><c-n>", {noremap = true})
vim.keymap.set("i", "<C-;>", "()<Left>", {noremap = true})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
return vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
