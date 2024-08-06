-- [nfnl] Compiled from fnl/config/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local function _lazygit_toggle()
  local term = require("toggleterm.terminal")
  local Terminal = term.Terminal
  local lazygit = Terminal:new({cmd = "lazygit", hidden = true})
  return lazygit:toggle()
end
return {_lazygit_toggle = _lazygit_toggle}
