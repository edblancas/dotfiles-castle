[{1 :Olical/conjure
    :ft [:clojure :fennel :lua]
    :lazy true
    :branch "master"
    :keys [{1 "<F16>" 2 "<cmd>ConjureLogToggle<cr>" :desc "Toggle Conjure Log"}
           {1 "<D-F16>" 2 "<cmd>ConjureLogResetSoft<cr>" :desc "Conjure Log Reset"}
           {1 "<M-F16>" 2 "<cmd>ConjureLogResetHard<cr>" :desc "Conjure Log Hard Reset"}
           {1 "<localleader>ld" 2 "<cmd>ConjureDocWord<cr>" :mode [:n] :desc "Conjure Doc Word"}]
    :init (fn []
            ; Alias for ConjureShadowSelect -> Csc
            (vim.cmd {:cmd "command" :args ["-nargs=1" "Cjc" "ConjureConnect" "<args>"] :bang true})
            (vim.cmd {:cmd "command" :args ["-nargs=1" "Cjss" "ConjureShadowSelect" "<args>"] :bang true})
            ; Some conjure settings
            (set vim.g.conjure#client#clojure#nrepl#eval#auto_require false)
            (set vim.g.conjure#client#clojure#nrepl#connection#auto_repl#enabled false)
            (set vim.g.conjure#client#clojure#nrepl#test#current_form_names ["deftest" "defflow" "defspec" "describe"]))}]
