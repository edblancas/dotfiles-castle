-- [nfnl] Compiled from fnl/plugins/neo-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local nvim = autoload("nvim")
local function _2_()
  local tree = require("neo-tree")
  return tree.setup({window = {mappings = {P = {"toggle_preview", config = {use_float = false}}}}, enable_diagnostics = false})
end
return {{"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, config = _2_, keys = {{"<D-1>", "<cmd>Neotree toggle<cr>", mode = {"i", "n"}}, {"<leader>tf", "<cmd>Neotree action=focus<cr>", mode = {"n"}, desc = "Neotree focus"}, {"<leader>tr", "<cmd>Neotree reveal<cr>", mode = {"n"}, desc = "Todo's Neotree reveal"}}}}
