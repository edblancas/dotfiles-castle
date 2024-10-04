-- [nfnl] Compiled from fnl/plugins/bookmarks.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local bk = require("bookmarks")
  local tl = require("telescope")
  bk.setup({keymap = {toggle = "<D-2>", add = "<F3>"}})
  tl.load_extension("bookmarks")
  vim.keymap.set({"n", "i"}, "<D-2>", "<cmd>lua require('bookmarks').toggle_bookmarks()<cr>")
  return vim.keymap.set({"n", "i"}, "<F3>", "<cmd>lua require('bookmarks').add_bookmarks()<cr>")
end
return {{"crusj/bookmarks.nvim", branch = "main", dependencies = {"nvim-tree/nvim-web-devicons"}, config = _1_}}
