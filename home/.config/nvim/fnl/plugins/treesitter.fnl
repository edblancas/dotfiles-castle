[{1 :nvim-treesitter/nvim-treesitter-context}

 {1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :indent {:enable true}
                                 :incremental_selection {:enable true
                                                         :keymaps {:init_selection "gnn" ;; set to `false` to disable one of the mappings
                                                                   :node_incremental "grn"
                                                                   :scope_incremental "grc"
                                                                   :node_decremental "grm"}}
                                 :sync_install false
                                 :auto_install true
                                 :indent {:enable true}
                                 :ensure_installed [:vimdoc
                                                    :python
                                                    :clojure
                                                    :fennel
                                                    :java
                                                    :javascript
                                                    :json
                                                    :lua
                                                    :markdown
                                                    :yaml]})))}]

