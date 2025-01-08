-- [nfnl] Compiled from fnl/plugins/undotree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end
return {{"mbbill/undotree", config = _1_}}
