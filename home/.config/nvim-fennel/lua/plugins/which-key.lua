-- [nfnl] Compiled from fnl/plugins/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local which = require("which-key")
  which.setup({})
  vim.o.timeout = true
  vim.o.timeoutlen = 500
  return nil
end
return {{"folke/which-key.nvim", event = "VeryLazy", init = _1_}}
