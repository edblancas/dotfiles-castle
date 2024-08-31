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
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set({"n", "v", "i"}, "<D-s>", "<cmd>wall<CR>")
vim.keymap.set({"n"}, "<leader>]", ":bn")
vim.keymap.set({"n"}, "<leader>[", ":bp")
vim.keymap.set({"n"}, "<F10>", "<C-w>|")
vim.keymap.set({"n"}, "<D-F10>", "<C-w>|")
vim.keymap.set({"n", "i"}, "<F16>", "<cmd>lua require('config.utils')['toggle-test-file']()<cr>")
return vim.keymap.set({"n", "i"}, "<F1>", "<nop>")
