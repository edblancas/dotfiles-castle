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
             {1 "<leader>rs" 2 ":Neotest summary<cr>" :desc "Display tests summary"}
             {1 "<leader>rw" 2 ":lua require('neotest').watch.toggle()" :desc "Watch test files"}
             {1 "<leader>rx" 2 ":lua require('neotest').run.stop()<cr>" :desc "Stop nearest test"}]}]
