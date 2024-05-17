[{1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :indent {:enable true}
                                 :ensure_installed [:clojure
                                                    :fennel
                                                    :java
                                                    :json
                                                    :lua
                                                    :markdown
                                                    :python]})))}]
