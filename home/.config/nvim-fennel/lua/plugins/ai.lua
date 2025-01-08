-- [nfnl] Compiled from fnl/plugins/ai.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local sm = require("supermaven-nvim")
  return sm.setup({keymaps = {accept_suggestion = "<C-CR>", accept_word = "<C-f>", clear_suggestion = "<C-BS>", ignore_filetypes = {"python"}}})
end
return {{"supermaven-inc/supermaven-nvim", config = _1_}}
