-- [nfnl] Compiled from fnl/plugins/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local t = require("transparent")
  t.setup({extra_groups = {}})
  return t.clear_prefix("NeoTree")
end
return {{"tpope/vim-sensible", enabled = false}, {"tpope/vim-repeat"}, {"tpope/vim-eunuch"}, {"tpope/vim-unimpaired"}, {"kylechui/nvim-surround", event = "VeryLazy", config = true}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {enable_check_bracket_line = false}}, {"stevearc/oil.nvim", config = true, opts = {default_file_explorer = true, view_options = {show_hidden = true}, columns = {"icon"}, delete_to_trash = true, skip_confirm_for_simple_edits = true}, dependencies = {"nvim-tree/nvim-web-devicons"}}, {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {indent = {char = "\226\150\143"}, scope = {char = "\226\150\143", show_end = false, show_start = false}}}, {"stevearc/conform.nvim", config = true, opts = {formatters_by_ft = {typescript = {"prettierd", "prettier", stop_after_first = true}, typescriptreact = {"prettierd", "prettier", stop_after_first = true}, javascript = {"prettierd", "prettier", stop_after_first = true}}}}, {"xiyaowong/transparent.nvim", config = _1_, enabled = false}}
