-- [nfnl] Compiled from fnl/plugins/git.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.keymap.set({"n", "i"}, "<D-0>", "<cmd>G<CR>")
end
return {{"lewis6991/gitsigns.nvim", config = true}, {"kdheepak/lazygit.nvim", cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile"}, dependencies = {"nvim-lua/plenary.nvim"}, keys = {{"<D-9>", "<cmd>LazyGit<cr>", mode = {"i", "n"}, desc = "LazyGit"}}}, {"tpope/vim-fugitive", config = _1_}}
