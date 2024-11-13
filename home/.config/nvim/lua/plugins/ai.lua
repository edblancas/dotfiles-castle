-- [nfnl] Compiled from fnl/plugins/ai.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local sm = require("supermaven-nvim")
  return sm.setup({keymaps = {acept_word = "<C-S-j>"}, ignore_filetypes = {"cpp"}})
end
return {{"supermaven-inc/supermaven-nvim", config = _1_}}
