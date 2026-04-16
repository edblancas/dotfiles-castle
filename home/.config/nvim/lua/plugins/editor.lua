return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufReadPost",
    main = 'ibl',
    opts = {
      indent = { char = "▏" },
      scope = {
        char = "▏",
        show_start = false,
        show_end = false
      }
    }
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>u",
        "<cmd>UndotreeToggle<CR>",
        desc = "Toggle undotree"
     }
    }
  }
}
