-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, indent = {enable = true}, incremental_selection = {enable = true, keymaps = {init_selection = "gnn", node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm"}}, auto_install = true, ensure_installed = {"vimdoc", "python", "clojure", "fennel", "java", "javascript", "typescript", "json", "lua", "markdown", "yaml"}, sync_install = false})
end
return {{"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_}}
