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
                                :extensions {:ui-select {1 (themes.get_dropdown {})}
                                             :fzf {}}
                                :pickers {:find_files {:find_command ["rg"
                                                                      "--files"
                                                                      "--iglob"
                                                                      "!.git"
                                                                      "--hidden"]
                                                       :theme :ivy}}})
              (telescope.load_extension "ui-select")
              (telescope.load_extension "fzf")
              ;transparent background
              ;(vim.api.nvim_set_hl 0 "TelescopeNormal" {:bg :none})
              (vim.keymap.set :n "<leader>sws" (grep-w "word") {:desc "telescope grep string word"})
              (vim.keymap.set :n "<leader>sWs" (grep-w "WORD") {:desc "telescope grep string WORD"})
              (vim.keymap.set :n "<leader>sf" builtin.find_files {:desc "telescope find files"})
              (vim.keymap.set :n "<leader>sd" builtin.git_files {:desc "telescope git files"})
              (vim.keymap.set :n "<leader>sg" builtin.live_grep {:desc "telescope live grep"})
              (vim.keymap.set :n "<leader>sb" builtin.buffers {:desc "telescope buffers"})
              (vim.keymap.set :n "<leader>sh" builtin.help_tags {:desc "telescope help tags"})))}]
