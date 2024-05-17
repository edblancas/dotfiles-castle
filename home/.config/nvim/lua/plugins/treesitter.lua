-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, auto_install = true, indent = {enable = true}, ensure_installed = {"python", "clojure", "fennel", "java", "javascript", "json", "lua", "markdown", "yaml"}, sync_install = false})
end
return {{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_}}
