(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})

;clear highlighting on enter in normal mode
(nvim.set_keymap :n :<CR> ":noh<CR><CR>" {:noremap true})

;duplicate currents panel in a new tab
(nvim.set_keymap :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

;escape from terminal normal mode
(nvim.set_keymap :t :<esc><esc> "<c-\\><c-n>" {:noremap true})

;; this is better than the above, see link:
;;   https://www.reddit.com/r/neovim/comments/uuh8xw/noob_vimkeymapset_vs_vimapinvim_set_keymap_key/
;; we don't use C-; cuz vim can't capture, see link:
;;   https://stackoverflow.com/a/23546206
(vim.keymap.set :i :<C-l> "()<Left>" {:noremap true})

{}

