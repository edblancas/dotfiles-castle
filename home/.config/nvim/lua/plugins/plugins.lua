-- [nfnl] Compiled from fnl/plugins/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local surround = require("nvim-surround")
  return surround.setup()
end
return {{"tpope/vim-sensible"}, {"tpope/vim-repeat"}, {"tpope/vim-eunuch"}, {"tpope/vim-unimpaired"}, {"tpope/vim-fugitive"}, {"benmills/vimux"}, {"christoomey/vim-tmux-navigator"}, {"tmux-plugins/vim-tmux"}, {"numToStr/Comment.nvim", opts = {toggler = {line = "<leader>cc", block = "<leader>cb"}, opleader = {line = "<leader>cc", block = "<leader>cb"}, extra = {above = "<leader>cO", below = "<leader>co", eol = "<leader>cA"}}}, {"kylechui/nvim-surround", event = "VeryLazy", config = _1_}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {}}}
