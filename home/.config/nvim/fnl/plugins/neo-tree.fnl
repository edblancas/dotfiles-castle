[{1 :nvim-neo-tree/neo-tree.nvim
    :branch "v3.x"
    :dependencies [:nvim-lua/plenary.nvim
                   :nvim-tree/nvim-web-devicons
                   :MunifTanjim/nui.nvim]
    :config (fn []
              (let [tree (require :neo-tree)]
                (tree.setup {:filesystem {:filtered_items {:hide_by_pattern ["/home/*/.config/nvim/lua/user/**.lua"]}
                             ;; Don't change the CWD if I open netrw style windows.
                             :cwd_target {:current :none}}})))}]
