[{1 :tpope/vim-sensible
    :enabled false}
 {1 :tpope/vim-repeat}
 {1 :tpope/vim-eunuch}
 {1 :tpope/vim-unimpaired}

 {1 :kylechui/nvim-surround
    :event "VeryLazy"
    :config true}
 {1 :windwp/nvim-autopairs
    :event "InsertEnter"
    :opts {:enable_check_bracket_line false}}

 {1 :stevearc/oil.nvim
    :config true
    :opts {:default_file_explorer true
           :view_options {:show_hidden true}
           :columns [:icon]
           :delete_to_trash true
           :skip_confirm_for_simple_edits true
           ; cuz <C-h> and <C-l> conflict with change of window between splits
           ; kitty and nvim
           :use_default_keymaps false
           :keymaps {:g? "actions.show_help"
                     :<CR> "actions.select"
                     :<C-v> {1 :actions.select :opts {:vertical true} :desc "Open the entry in a vertical split"}
                     :<C-s> {1 :actions.select :opts {:horizontal true} :desc "Open the entry in a horizontal split"}
                     :<C-t> {1 :actions.select :opts {:tab true} :desc "Open the entry in new tab"}
                     :<C-p> "actions.preview"
                     :<C-c> "actions.close"
                     :<C-r> "actions.refresh"
                     :- "actions.parent"
                     :_ "actions.open_cwd"
                     "`" "actions.cd"
                     "~" {1 :actions.cd :opts {:scope "tab"} :desc ":tcd to the current oil directory" :mode "n"}
                     :gs "actions.change_sort"
                     :gx "actions.open_external"
                     :g. "actions.toggle_hidden"
                     :g\\ "actions.toggle_trash"}}
    :dependencies [:nvim-tree/nvim-web-devicons]}

 {1 :lukas-reineke/indent-blankline.nvim
    :main :ibl
    :opts {:indent {:char "▏"}
           :scope {:char "▏"
                   :show_start false
                   :show_end false}}}

 {1 :stevearc/conform.nvim
    :config true
    :opts {:formatters_by_ft {:typescript {1 "prettierd" 2 "prettier" :stop_after_first true}
                              :typescriptreact {1 "prettierd" 2 "prettier" :stop_after_first true}
                              :javascript {1 "prettierd" 2 "prettier" :stop_after_first true}}}}

  {1 :xiyaowong/transparent.nvim
     :enabled false
     :config (fn []
               (let [t (require :transparent)]
                 (t.setup {:extra_groups []})
                 (t.clear_prefix :NeoTree)))}]

