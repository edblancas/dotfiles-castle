[{1 :Olical/conjure
    :ft [:clojure :fennel :lua]
    :lazy true
    :branch "master"
    :keys [{1 "<F18>" 2 "<cmd>ConjureLogToggle<cr>" :desc "Toggle Conjure Log"}
           {1 "<C-F18>" 2 "<cmd>ConjureLogResetHard<cr>" :desc "Conjure Log Hard Reset"}]
    :init (fn []
            ; Alias for ConjureShadowSelect -> Csc
            (vim.cmd {:cmd "command" :args ["-nargs=1" "Cjc" "ConjureConnect" "<args>"] :bang true})
            (vim.cmd {:cmd "command" :args ["-nargs=1" "Cjss" "ConjureShadowSelect" "<args>"] :bang true})
            ; Some conjure settings
            (set vim.g.conjure#mapping#doc_word "K")
            (set vim.g.conjure#client#clojure#nrepl#eval#auto_require false)
            (set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
            (set vim.g.conjure#client#clojure#nrepl#test#current_form_names ["deftest" "defflow" "defspec" "describe"]))}]
