return {
  {
    "vim-test/vim-test",
    config = function()
      vim.cmd("let test#strategy = 'basic'")
      vim.cmd("let test#python#runner = 'pyunit'")
    end
    ,
    keys = {
      { "<leader>tf", ":TestFile<cr>",    desc = "[vim-test] Run current test file" },
      { "<leader>tn", ":TestNearest<cr>", desc = "[vim-test] Run nearest test" },
      { "<leader>ts", ":TestSuite<cr>",   desc = "[vim-test] Run all tests" },
      { "<leader>tl", ":TestLast<cr>",    desc = "[vim-test] Run last test" },
      { "<leader>tv", ":TestVisit<cr>",   desc = "[vim-test] Visit test" } }
  }
}
