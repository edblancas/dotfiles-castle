(lambda color-my-pencils [?color]
  (let [color (or color :rose-pine)]
    (vim.cmd.colorscheme color)
    (vim.api.nvim_set_hl 0 :Normal {:bg :none})
    (vim.api.nvim_set_hl 0 :NormalFloat {:bg :none})))

[{1 :rose-pine/neovim
    :name :rose-pine
    :config (fn []
              (let [rose-pine (require :rose-pine)]
                ;;(rose-pine.setup {:disable_background true})
                (vim.cmd "colorscheme rose-pine-moon")
                ;;(color-my-pencils)
                ))}]

