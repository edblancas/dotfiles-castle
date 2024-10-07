(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :nvim-neo-tree/neo-tree.nvim
    :branch "v3.x"
    :dependencies [:nvim-lua/plenary.nvim
                   :nvim-tree/nvim-web-devicons
                   :MunifTanjim/nui.nvim]
    :config (fn []
              (let [tree (require :neo-tree)]
                (tree.setup {:enable_diagnostics false})))
    :keys [{1 "<D-1>" 2 "<cmd>Neotree toggle<cr>" :mode [:i :n]}
           {1 "<leader>tf" 2 "<cmd>Neotree action=focus<cr>" :mode [:n] :desc "Neotree focus"}
           {1 "<leader>tr" 2 "<cmd>Neotree reveal<cr>" :mode [:n] :desc "Todo's Neotree reveal"}]}]

