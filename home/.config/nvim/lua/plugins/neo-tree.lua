-- [nfnl] Compiled from fnl/plugins/neo-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local tree = require("neo-tree")
  return tree.setup({filesystem = {filtered_items = {hide_by_pattern = {"/home/*/.config/nvim/lua/user/**.lua"}}, cwd_target = {current = "none"}}})
end
return {{"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, config = _1_}}
