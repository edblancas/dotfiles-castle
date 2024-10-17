[{1 :L3MON4D3/LuaSnip
    :name :LuaSnip
    ;Follow latest release.
    :version "v2.*" ;Replace <CurrentMajor> by the latest released major (first number of latest release)
    ;install jsregexp (optional!).
    :build "make install_jsregexp"
    ;https://youtu.be/Dn800rlPIho?t=481
    :config (fn []
              (let [ls (require :luasnip)
                    types (require :luasnip.util.types)
                    ls-loader (require :luasnip.loaders.from_lua)]
                (ls.config.set_config {:history true
                                       :updateevents "TextChanged,TextChangedI"
                                       :ext_opts {types.choiceNode {:active 
                                                                    {:virt_text [["<-" "Error"]]}}}})
                (vim.keymap.set [:i :s :n]
                                :<C-D-k> 
                                (fn []
                                  (if (ls.expand_or_jumpable) (ls.expand_or_jump)))
                                {:silent true})
                (vim.keymap.set [:i :s :n] 
                                :<C-D-j> 
                                (fn []
                                  (if (ls.jumpable -1) (ls.jump -1)))
                                {:silent true})
                (vim.keymap.set [:i] 
                                :<C-D-l> 
                                (fn []
                                  (if (ls.choice_active) (ls.change_choice 1)))
                                {:silent true})
                (ls-loader.load {:paths "~/.config/nvim/lua/snippets"})))}]


