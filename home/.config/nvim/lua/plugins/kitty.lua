-- [nfnl] Compiled from fnl/plugins/kitty.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local kn = require("kitty-navigator")
  vim.keymap.set("n", "<C-j>", kn.navigateDown, {silent = false})
  vim.keymap.set("n", "<C-k>", kn.navigateUp, {silent = false})
  vim.keymap.set("n", "<C-l>", kn.navigateRight, {silent = false})
  return vim.keymap.set("n", "<C-h>", kn.navigateLeft, {silent = false})
end
return {{"jghauser/kitty-runner.nvim"}, {"MunsMan/kitty-navigator.nvim", config = _1_, build = {"cp navigate_kitty.py ~/.config/kitty", "cp pass_keys.py ~/.config/kitty"}}}
