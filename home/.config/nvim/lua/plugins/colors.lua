-- [nfnl] Compiled from fnl/plugins/colors.fnl by https://github.com/Olical/nfnl, do not edit.
local function color_my_pencils(_3fcolor)
  local color = (color or "rose-pine")
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
  return vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
end
local function _1_()
  local rose_pine = require("rose-pine")
  return vim.cmd("colorscheme rose-pine-moon")
end
return {{"rose-pine/neovim", name = "rose-pine", config = _1_}}
