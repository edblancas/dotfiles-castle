return {
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = "G",
    keys = {
      {
        "<M-0>",
        "<cmd>G<CR>",
        mode = { "n", 'i' }
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true
  }
}
