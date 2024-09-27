-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, indent = {enable = true}, incremental_selection = {enable = true, keymaps = {init_selection = "gnn", node_incremental = "grn", scope_incremental = "grc", node_decremental = "grm"}}, auto_install = true, ensure_installed = {"vimdoc", "python", "clojure", "fennel", "java", "javascript", "typescript", "json", "lua", "markdown", "yaml"}, sync_install = false})
end
return {{"nvim-treesitter/nvim-treesitter-context"}, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = _1_}, {"nvim-treesitter/nvim-treesitter-textobjects", config = true, main = "nvim-treesitter.configs", opts = {textobjects = {select = {enable = true, lookahead = true, keymaps = {af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = {query = "@class.inner", desc = "Select inner part of a class region"}}, selection_modes = {["@parameter.outer"] = "v", ["@function.outer"] = "V", ["@class.outer"] = "<c-v>"}, include_surrounding_whitespace = true}}}}}
