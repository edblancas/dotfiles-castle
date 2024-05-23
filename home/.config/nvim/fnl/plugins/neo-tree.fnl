(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :nvim-neo-tree/neo-tree.nvim
    :branch "v3.x"
    :dependencies [:nvim-lua/plenary.nvim
                   :nvim-tree/nvim-web-devicons
                   :MunifTanjim/nui.nvim]
    :config (fn []
              (let [tree (require :neo-tree)]
                (tree.setup {})))
    :init (fn []
            (nvim.ex.hi "NvimTreeSpecialFile ctermfg=7 guifg=#c6c6c6")
            (nvim.set_keymap :n :<leader>tt ":Neotree toggle<CR>" {:noremap true})
            (nvim.set_keymap :n :<leader>tf ":Neotree action=focus<CR>" {:noremap true})
            (nvim.set_keymap :n :<leader>tr ":Neotree reveal<CR>" {:noremap true}))}]
