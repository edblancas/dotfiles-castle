; lua require('neotest').watch.toggle(vim.fn.expand('%:h:h') .. '/test/' .. 'test_' .. vim.fn.expand('%:t'))
(fn open-test-watch-n-summary []
  (let [nt (require :neotest)
        test-path (vim.fn.expand "%:h:h")
        test-filepath (.. "/test/" "test_" (vim.fn.expand "%:t"))]
    (nt.watch.toggle (.. test-path test-filepath))
    (nt.summary.toggle)))

[{1 :nvim-neotest/neotest
    :dependencies [:nvim-neotest/nvim-nio
                   :nvim-lua/plenary.nvim
                   :antoinemadec/FixCursorHold.nvim
                   :nvim-treesitter/nvim-treesitter
                   ;python runner 
                   :nvim-neotest/neotest-python]
    :config (fn []
              (let [nt (require :neotest)]
                (nt.setup {:adapters [(require :neotest-python)]})))
    :keys [{1 "<leader>rt" 2 ":lua require('neotest').run.run()<cr>" :desc "Run nearest test"}
           {1 "<leader>rf" 2 ":lua require('neotest').run.run()<cr>" :desc "Run current test file"}
           {1 "<leader>rs" 2 ":Neotest summary<cr>" :desc "Display test summary"}
           {1 "<F17>" 2 ":Neotest summary<cr>" :desc "Display test summary"}
           {1 "<leader>rw" 2 ":lua require('neotest').watch.toggle()<cr>" :desc "Watch test files"}
           {1 "<leader>rx" 2 ":lua require('neotest').run.stop()<cr>" :desc "Stop nearest test"}
           ; {1 "<F16>" 2 open-test-watch-n-summary :desc "Open test file, watch and summary"}
           ]}]
