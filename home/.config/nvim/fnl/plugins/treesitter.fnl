[{1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :sync_install false
                                 :auto_install true
                                 :indent {:enable true}
                                 :ensure_installed [:python
                                                    :clojure
                                                    :fennel
                                                    :java
                                                    :javascript
                                                    :json
                                                    :lua
                                                    :markdown
                                                    :yaml]})))}]

