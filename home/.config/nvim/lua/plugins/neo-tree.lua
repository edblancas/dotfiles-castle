-- [nfnl] Compiled from fnl/plugins/neo-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local tree = require("neo-tree")
  local defaults = require("neo-tree.defaults")
  defaults["enable_diagnostics"] = false
  return tree.setup(defaults)
end
local function _3_()
  nvim.ex.hi("NvimTreeSpecialFile ctermfg=7 guifg=#c6c6c6")
  nvim.set_keymap("n", "<leader>tt", ":Neotree toggle<CR>", {noremap = true})
  vim.keymap.set({"n", "v", "i"}, "<D-1>", ":Neotree toggle<CR>", {noremap = true})
  nvim.set_keymap("n", "<leader>tf", ":Neotree action=focus<CR>", {noremap = true})
  return nvim.set_keymap("n", "<leader>tr", ":Neotree reveal<CR>", {noremap = true})
end
return {{"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, config = _2_, init = _3_}}
