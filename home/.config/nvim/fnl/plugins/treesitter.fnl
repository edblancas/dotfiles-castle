[
 {1 :nvim-treesitter/nvim-treesitter-context}

 {1 :stevearc/aerial.nvim
    :dependencies [:nvim-treesitter/nvim-treesitter :nvim-tree/nvim-web-devicons]
    :config (fn []
              (let [aerial (require :aerial)]
                (vim.keymap.set [:n :i] "<D-7>" "<cmd>AerialToggle!<CR>")
                (aerial.setup {:on_attach (fn [bufnr]
                                            ;Jump forwards/backwards with '{' and '}'
                                            (vim.keymap.set "n" "{" "<cmd>AerialPrev<CR>" {:buffer bufnr})
                                            (vim.keymap.set "n" "}" "<cmd>AerialNext<CR>" {:buffer bufnr})
                                            )})))}

 {1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :indent {:enable true}
                                 :incremental_selection {:enable true
                                                         :keymaps {:init_selection "gnn" ;; set to `false` to disable one of the mappings
                                                                   :node_incremental "grn"
                                                                   :scope_incremental "grc"
                                                                   :node_decremental "grm"}}
                                 :sync_install false
                                 :auto_install true
                                 :indent {:enable true}
                                 :ensure_installed [:vimdoc
                                                    :python
                                                    :clojure
                                                    :fennel
                                                    :java
                                                    :javascript
                                                    :typescript
                                                    :json
                                                    :lua
                                                    :markdown
                                                    :yaml]})))}
  
 {1 :nvim-treesitter/nvim-treesitter-textobjects
    :config true
    :main :nvim-treesitter.configs
    :opts {:textobjects
           {:select
            {:enable true

             ;; Automatically jump forward to textobj, similar to targets.vim
             :lookahead true

             :keymaps
             {;; Capture groups defined in textobjects.scm
              "af" "@function.outer"
              "if" "@function.inner"
              "ac" "@class.outer"
              ;; Optionally set descriptions to the mappings
              "ic" {:query "@class.inner" :desc "Select inner part of a class region"}}

             ;; Select mode (default is charwise 'v')
             :selection_modes
             {"@parameter.outer" "v" ;; charwise
              "@function.outer" "V" ;; linewise
              "@class.outer" "<c-v>"} ;; blockwise

             ;; Include surrounding whitespace (default is false)
             :include_surrounding_whitespace true}}}}]

