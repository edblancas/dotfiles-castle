[{1 :lewis6991/gitsigns.nvim
    :config true}
 {1 :kdheepak/lazygit.nvim
    :cmd ["LazyGit"
          "LazyGitConfig"
          "LazyGitCurrentFile"
          "LazyGitFilter"
          "LazyGitFilterCurrentFile"]
    ;optional for floating window border decoration
    :dependencies ["nvim-lua/plenary.nvim"]
    ;setting the keybinding for LazyGit with 'keys' is recommended in
    ;order to load the plugin when the command is run for the first time
    :keys [{1 "<leader>lg" 2 "<cmd>LazyGit<cr>" :desc "LazyGit"}]}
 {1 :tpope/vim-fugitive
    :lazy true}]

