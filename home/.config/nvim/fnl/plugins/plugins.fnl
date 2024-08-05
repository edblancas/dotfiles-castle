[{1 :tpope/vim-sensible}
 {1 :tpope/vim-repeat}
 {1 :tpope/vim-eunuch}
 {1 :tpope/vim-unimpaired}

 {1 :tpope/vim-fugitive}

 {1 :benmills/vimux}
 {1 :christoomey/vim-tmux-navigator}
 {1 :tmux-plugins/vim-tmux}

 {1 :numToStr/Comment.nvim
    :opts {:toggler {:line "<leader>cc"
                     :block "<leader>cb"}
           :opleader {:line "<leader>cc"
                      :block "<leader>cb"}
           :extra {:above "<leader>cO"
                   :below "<leader>co"
                   :eol "<leader>cA"}}}
 {1 :kylechui/nvim-surround
    :event "VeryLazy"
    :config (fn []
              (let [surround (require :nvim-surround)]
                (surround.setup)))}
 {1 :windwp/nvim-autopairs
    :event "InsertEnter"
    :opts {:enable_check_bracket_line false}}]

