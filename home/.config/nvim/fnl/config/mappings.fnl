(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})

;clear highlighting on enter in normal mode
(nvim.set_keymap :n :<CR> ":noh<CR><CR>" {:noremap true})
