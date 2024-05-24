[{1 :folke/which-key.nvim
    :event :VeryLazy
    :init (fn []
            (local which (require :which-key))
            (which.setup {})
            (set vim.o.timeout true)
            (set vim.o.timeoutlen 500))}]

