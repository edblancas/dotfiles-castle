return {
  {
    'xiyaowong/transparent.nvim',
    event = "VeryLazy",
    config = function()
      require('transparent').setup({
        extra_groups = {}
      })
    end,
  }
}
