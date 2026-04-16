return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = "G",
    keys = {
      {
        "<M-0>",
        "<cmd>G<CR>",
        mode = { "n", 'i' },
        desc = "Git: open fugitive"
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPost",
    config = true
  }
}
