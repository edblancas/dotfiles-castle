-- [nfnl] Compiled from fnl/plugins/testing.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local nt = require("neotest")
  return nt.setup({adapters = {require("neotest-python")}})
end
return {{"nvim-neotest/neotest", dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-python"}, config = _1_, keys = {{"<leader>rt", ":lua require('neotest').run.run()<cr>", desc = "Run nearest test"}, {"<leader>rf", ":lua require('neotest').run.run()<cr>", desc = "Run current test file"}, {"<F17>", ":Neotest summary<cr>", desc = "Display test summary"}, {"<leader>rw", ":lua require('neotest').watch.toggle()<cr>", desc = "Watch test files"}, {"<leader>rx", "<cmd>Neotest stop<cr>", desc = "Stop test"}}}}
