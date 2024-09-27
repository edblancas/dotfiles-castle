-- [nfnl] Compiled from fnl/plugins/kitty.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local ks = require("kitty-scrollback")
  return ks.setup()
end
local function _2_()
  local kr = require("kitty-runner")
  local krc = require("kitty-runner.config")
  return kr.setup(krc.window_config)
end
local function _3_()
  local kn = require("kitty-navigator")
  vim.keymap.set({"n", "i"}, "<C-j>", kn.navigateDown, {silent = false})
  vim.keymap.set({"n", "i"}, "<C-k>", kn.navigateUp, {silent = false})
  vim.keymap.set({"n", "i"}, "<C-l>", kn.navigateRight, {silent = false})
  return vim.keymap.set({"n", "i"}, "<C-h>", kn.navigateLeft, {silent = false})
end
return {{"mikesmithgh/kitty-scrollback.nvim", enabled = true, lazy = true, cmd = {"KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth"}, event = {"User KittyScrollbackLaunch"}, version = "*", config = _1_}, {"edblancas/kitty-runner.nvim", branch = "fix", config = _2_}, {"MunsMan/kitty-navigator.nvim", config = _3_, build = {"cp navigate_kitty.py ~/.config/kitty", "cp pass_keys.py ~/.config/kitty"}}}
