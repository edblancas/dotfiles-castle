-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")
  telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, extensions = {["ui-select"] = {themes.get_dropdown({})}}, pickers = {find_files = {find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}}}})
  telescope.load_extension("ui-select")
  vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
  vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
  return vim.keymap.set("n", "<leader>hh", builtin.help_tags, {})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-telescope/telescope-ui-select.nvim", "nvim-lua/plenary.nvim"}, config = _1_}}
