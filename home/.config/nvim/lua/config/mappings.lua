-- [nfnl] Compiled from fnl/config/mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.set_keymap("n", "<CR>", ":noh<CR><CR>", {noremap = true})
nvim.set_keymap("n", "<C-w>T", ":tab split<CR>", {noremap = true, silent = true})
nvim.set_keymap("t", "<esc><esc>", "<c-\\><c-n>", {noremap = true})
vim.keymap.set("i", "<C-l>", "()<Left>", {noremap = true})
vim.keymap.set("i", "<D-l>", "Cmd + l", {noremap = true})
vim.keymap.set("i", "<M-C-l>", "Option + Control  + l", {noremap = true})
return vim.keymap.set("i", "\194\172", "Option  + l", {noremap = true})
