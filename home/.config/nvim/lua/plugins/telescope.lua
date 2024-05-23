-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  telescope.setup({})
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
  local function _2_()
    local word = vim.fn.expand("<cword>")
    return builtin.grep_string({search = word})
  end
  vim.keymap.set("n", "<leader>sp", _2_)
  local function _3_()
    local word = vim.fn.expand("<cWord>")
    return builtin.grep_string({search = word})
  end
  vim.keymap.set("n", "<leader>swp", _3_)
  local function _4_()
    return builtin.grep_string({search = vim.fn.input("Grep > ")})
  end
  vim.keymap.set("n", "<leader>ps", _4_)
  vim.keymap.set("n", "<leader>hh", builtin.help_tags, {})
  vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
  return vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"}, config = _1_}}
