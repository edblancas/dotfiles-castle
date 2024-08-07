[{1 :mikesmithgh/kitty-scrollback.nvim
    :enabled true
    :lazy true
    :cmd ["KittyScrollbackGenerateKittens" "KittyScrollbackCheckHealth"]
    :event ["User KittyScrollbackLaunch"]
    :version :* ; latest stable version, may have breaking changes if major version changed
    :config (fn [] (let [ks (require :kitty-scrollback)] (ks.setup)))}

 {1 :jghauser/kitty-runner.nvim
    :config (fn []
              (let [kr (require :kitty-runner)
                    krc (require :kitty-runner.config)]
                (kr.setup krc.window_config)))}

 {1 :MunsMan/kitty-navigator.nvim
    :config (fn []
              (let [kn (require :kitty-navigator)]
                	(vim.keymap.set :n :<C-j> kn.navigateDown {:silent false})
                	(vim.keymap.set :n :<C-k> kn.navigateUp {:silent false})
                	(vim.keymap.set :n :<C-l> kn.navigateRight {:silent false})
                  (vim.keymap.set :n :<C-h> kn.navigateLeft {:silent false})))
    :build ["cp navigate_kitty.py ~/.config/kitty"
            "cp pass_keys.py ~/.config/kitty"]}]
