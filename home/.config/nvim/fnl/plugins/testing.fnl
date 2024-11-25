[{1 :nvim-neotest/neotest
    :dependencies [:nvim-neotest/nvim-nio
                   :nvim-lua/plenary.nvim
                   :antoinemadec/FixCursorHold.nvim
                   :nvim-treesitter/nvim-treesitter
                   ;python runner 
                   :nvim-neotest/neotest-python
                   :nvim-neotest/neotest-jest]
    :config (fn []
              (let [nt (require :neotest)]
                (nt.setup {:adapters [(require :neotest-python)
                                      (require :neotest-jest)]})))
    :keys [{1 "<leader>rt" 2 ":lua require('neotest').run.run()<cr>" :desc "Run nearest test"}
           {1 "<leader>rf" 2 ":lua require('neotest').run.run()<cr>" :desc "Run current test file"}
           {1 "<F17>" 2 ":Neotest summary<cr>" :desc "Display test summary"}
           {1 "<C-F17>" 2 ":Neotest output-panel<cr>" :desc "Display test output-panel"}
           {1 "<C-F16>" 2 ":lua require('neotest').watch.toggle()<cr>" :desc "Watch test file"}
           {1 "<leader>rw" 2 ":lua require('neotest').watch.toggle()<cr>" :desc "Watch test file"}
           {1 "<leader>rx" 2 "<cmd>Neotest stop<cr>" :desc "Stop test"}]}

 {1 :vim-test/vim-test
    :config (fn []
              (vim.cmd "let test#strategy = 'basic'")
              (vim.cmd "let test#python#runner = 'pyunit'"))
    :keys [{1 "<leader>tb" 2 ":TestFile<cr>" :desc "[vim-test] Run current test file"}
           {1 "<leader>tn" 2 ":TestNearest<cr>" :desc "[vim-test] Run nearest test"}
           {1 "<leader>ts" 2 ":TestSuite<cr>" :desc "[vim-test] Run all tests"}
           {1 "<leader>tl" 2 ":TestLast<cr>" :desc "[vim-test] Run last test"}
           {1 "<leader>tv" 2 ":TestVisit<cr>" :desc "[vim-test] Visit test"}]}]
