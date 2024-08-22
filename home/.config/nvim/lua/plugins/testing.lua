-- [nfnl] Compiled from fnl/plugins/testing.fnl by https://github.com/Olical/nfnl, do not edit.
local function open_test_watch_n_summary()
  local nt = require("neotest")
  local test_path = vim.fn.expand("%:h:h")
  local test_filepath = ("/test/" .. "test_" .. vim.fn.expand("%:t"))
  nt.watch.toggle((test_path .. test_filepath))
  return nt.summary.toggle()
end
local function _1_()
  local nt = require("neotest")
  return nt.setup({adapters = {require("neotest-python")}})
end
return {{"nvim-neotest/neotest", dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-python"}, config = _1_, keys = {{"<leader>rt", ":lua require('neotest').run.run()<cr>", desc = "Run nearest test"}, {"<leader>rf", ":lua require('neotest').run.run()<cr>", desc = "Run current test file"}, {"<leader>rs", ":Neotest summary<cr>", desc = "Display test summary"}, {"<F17>", ":Neotest summary<cr>", desc = "Display test summary"}, {"<leader>rw", ":lua require('neotest').watch.toggle()<cr>", desc = "Watch test files"}, {"<leader>rx", ":lua require('neotest').run.stop()<cr>", desc = "Stop nearest test"}}}}
