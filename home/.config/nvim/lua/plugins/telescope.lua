-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  telescope.setup({})
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
  vim.keymap.set("n", "<leader>hh", builtin.help_tags, {})
  vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
  return vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}}
