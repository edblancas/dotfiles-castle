-- [nfnl] Compiled from fnl/plugins/kitty.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local kr = require("kitty-runner")
  local krc = require("kitty-runner.config")
  return kr.setup(krc.window_config)
end
local function _2_()
  local kn = require("kitty-navigator")
  vim.keymap.set("n", "<C-j>", kn.navigateDown, {silent = false})
  vim.keymap.set("n", "<C-k>", kn.navigateUp, {silent = false})
  vim.keymap.set("n", "<C-l>", kn.navigateRight, {silent = false})
  return vim.keymap.set("n", "<C-h>", kn.navigateLeft, {silent = false})
end
return {{"jghauser/kitty-runner.nvim", config = _1_}, {"MunsMan/kitty-navigator.nvim", config = _2_, build = {"cp navigate_kitty.py ~/.config/kitty", "cp pass_keys.py ~/.config/kitty"}}}
