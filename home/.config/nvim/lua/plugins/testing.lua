-- [nfnl] Compiled from fnl/plugins/testing.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local nt = require("neotest")
  return nt.setup({adapters = {require("neotest-python"), require("neotest-jest")}})
end
local function _2_()
  return vim.cmd("let test#strategy = 'kitty'")
end
return {{"nvim-neotest/neotest", dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-python", "nvim-neotest/neotest-jest"}, config = _1_, keys = {{"<leader>rt", ":lua require('neotest').run.run()<cr>", desc = "Run nearest test"}, {"<leader>rf", ":lua require('neotest').run.run()<cr>", desc = "Run current test file"}, {"<F17>", ":Neotest summary<cr>", desc = "Display test summary"}, {"<C-F17>", ":Neotest output-panel<cr>", desc = "Display test output-panel"}, {"<C-F16>", ":lua require('neotest').watch.toggle()<cr>", desc = "Watch test file"}, {"<leader>rw", ":lua require('neotest').watch.toggle()<cr>", desc = "Watch test file"}, {"<leader>rx", "<cmd>Neotest stop<cr>", desc = "Stop test"}}}, {"vim-test/vim-test", config = _2_, keys = {{"<leader>tb", ":TestFile<cr>", desc = "Run current test file"}, {"<leader>tn", ":TestNearest<cr>", desc = "Run nearest test"}, {"<leader>ts", ":TestSuite<cr>", desc = "Run all tests"}, {"<leader>tl", ":TestLast<cr>", desc = "Run last test"}, {"<leader>tv", ":TestVisit<cr>", desc = "Visit test"}}}}
