[{1 :jghauser/kitty-runner.nvim}
 {1 :MunsMan/kitty-navigator.nvim
    :config (fn []
              (let [kn (require :kitty-navigator)]
                	(vim.keymap.set :n :<C-j> kn.navigateDown {:silent false})
                	(vim.keymap.set :n :<C-k> kn.navigateUp {:silent false})
                	(vim.keymap.set :n :<C-l> kn.navigateRight {:silent false})
                  (vim.keymap.set :n :<C-h> kn.navigateLeft {:silent false})))
    :build ["cp navigate_kitty.py ~/.config/kitty"
            "cp pass_keys.py ~/.config/kitty"]}]
