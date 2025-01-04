-- [nfnl] Compiled from fnl/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")
  local grep_w
  local function _2_(mode)
    local function _3_()
      return builtin.grep_string({search = vim.fn.expand(("<c" .. mode .. ">"))})
    end
    return _3_
  end
  grep_w = _2_
  telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, extensions = {["ui-select"] = {themes.get_dropdown({})}, fzf = {}}, pickers = {find_files = {find_command = {"rg", "--files", "--iglob", "!.git", "--hidden"}, theme = "ivy"}}})
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
  vim.keymap.set("n", "<leader>sws", grep_w("word"), {desc = "telescope grep string word"})
  vim.keymap.set("n", "<leader>sWs", grep_w("WORD"), {desc = "telescope grep string WORD"})
  vim.keymap.set("n", "<leader>sf", builtin.find_files, {desc = "telescope find files"})
  vim.keymap.set("n", "<leader>sd", builtin.git_files, {desc = "telescope git files"})
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, {desc = "telescope live grep"})
  vim.keymap.set("n", "<leader>sb", builtin.buffers, {desc = "telescope buffers"})
  return vim.keymap.set("n", "<leader>sh", builtin.help_tags, {desc = "telescope help tags"})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-telescope/telescope-ui-select.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}}, config = _1_}}
