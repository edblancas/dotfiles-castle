[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim]
  :config (fn []
            (let [telescope (require :telescope)
                  builtin   (require :telescope.builtin)]
              (telescope.setup {})
              (vim.keymap.set :n "<leader>ff" builtin.find_files {})
              (vim.keymap.set :n "<leader>pf" builtin.git_files {})
              (vim.keymap.set :n "<leader>hh" builtin.help_tags {})
              (vim.keymap.set :n "<leader>pb" builtin.buffers {})
              (vim.keymap.set :n "<leader>ps" builtin.live_grep {})))}]

