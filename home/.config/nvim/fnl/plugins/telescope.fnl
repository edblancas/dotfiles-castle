[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-telescope/telescope-ui-select.nvim
                 :nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim
                 {1 :nvim-telescope/telescope-fzf-native.nvim :build "make"}]
  :config (fn []
            (let [telescope (require :telescope)
                  builtin   (require :telescope.builtin)
                  themes    (require :telescope.themes)
                  grep-w    (fn [mode]
                              (fn []
                                (builtin.grep_string {:search
                                                      (vim.fn.expand (.. "<c" mode ">"))})))]
              (telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]
                                           :vimgrep_arguments ["rg"
                                                               "--color=never"
                                                               "--no-heading"
                                                               "--with-filename"
                                                               "--line-number"
                                                               "--column"
                                                               "--smart-case"
                                                               "--iglob"
                                                               "!.git"
                                                               "--hidden"]}
                                :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                :pickers {:find_files {:find_command ["rg"
                                                                      "--files"
                                                                      "--iglob"
                                                                      "!.git"
                                                                      "--hidden"]}}})
              (telescope.load_extension "ui-select")
              ;transparent background
              ;(vim.api.nvim_set_hl 0 "TelescopeNormal" {:bg :none})
              (vim.keymap.set :n "<leader>fws" (grep-w "word") {:desc "telescope grep string word"})
              (vim.keymap.set :n "<leader>fWs" (grep-w "WORD") {:desc "telescope grep string WORD"})
              (vim.keymap.set :n "<leader>ff" builtin.find_files {:desc "telescope find files"})
              (vim.keymap.set :n "<leader>fg" builtin.git_files {:desc "telescope git files"})
              (vim.keymap.set [:n :i] "<D-O>" builtin.find_files {})
              (vim.keymap.set :n "<leader>fs" builtin.live_grep {:desc "telescope live grep"})
              (vim.keymap.set [:n :i] "<D-F>" builtin.live_grep {})
              (vim.keymap.set :n "<leader>fb" builtin.buffers {:desc "telescope buffers"})
              (vim.keymap.set [:n :i] "<D-e>" builtin.buffers {})
              (vim.keymap.set :n "<leader>fh" builtin.help_tags {:desc "telescope help tags"})))}]
