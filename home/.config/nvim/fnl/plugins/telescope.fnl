[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim]
  :config (fn []
            (let [telescope (require :telescope)
                  builtin   (require :telescope.builtin)]
              (telescope.setup {})
              (vim.keymap.set :n "<leader>pf" builtin.find_files {})
              (vim.keymap.set :n "<C-p>" builtin.git_files {})
              (vim.keymap.set :n "<leader>pws" (fn []
                                                 (let [word (vim.fn.expand "<cword>")]
                                                   (builtin.grep_string {:search word}))))
              (vim.keymap.set :n "<leader>pWs" (fn []
                                                 (let [word (vim.fn.expand "<cWord>")]
                                                   (builtin.grep_string {:search word}))))
              (vim.keymap.set :n "<leader>ps" (fn [] 
                                                (builtin.grep_string {:search (vim.fn.input "Grep > ")})))
              (vim.keymap.set :n "<leader>vh" builtin.help_tags {})))}]

