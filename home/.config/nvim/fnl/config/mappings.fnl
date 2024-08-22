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
(vim.keymap.set :i "<C-;>" "()<Left>" {:noremap true})

;move lines
(vim.keymap.set "v" "J" ":m '>+1<CR>gv=gv")
(vim.keymap.set "v" "K" ":m '<-2<CR>gv=gv")

;glue lines without move the cursor
(vim.keymap.set "n" "J" "mzJ`z")
;move page down/up with cursos in middle
(vim.keymap.set "n" "<C-d>" "<C-d>zz")
(vim.keymap.set "n" "<C-u>" "<C-u>zz")
; ?
(vim.keymap.set "n" "n" "nzzzv")
(vim.keymap.set "n" "N" "Nzzzv")

;when selected some text and exec then replace
;the text with the text in the register and
;mantain this text in the register
;previously the text replaced will be in the register
(vim.keymap.set "x" "<leader>p" "\"_dP")

;delete and text discarded
(vim.keymap.set [:n :v] "<leader>d" "\"_d")

(vim.keymap.set "n" "<C-k>" "<cmd>cnext<CR>zz")
(vim.keymap.set "n" "<C-j>" "<cmd>cprev<CR>zz")
(vim.keymap.set "n" "<leader>k" "<cmd>lnext<CR>zz")
(vim.keymap.set "n" "<leader>j" "<cmd>lprev<CR>zz")

(vim.keymap.set [:n :v :i] "<D-s>" "<cmd>W<CR>")

(vim.keymap.set [:n] "<leader>]" ":bn")
(vim.keymap.set [:n] "<leader>[" ":bp")

(vim.keymap.set [:n] "<F10>" "<C-w>|")
(vim.keymap.set [:n] "<D-F10>" "<C-w>|")

(vim.keymap.set [:n :i] "<F16>" "<cmd>lua require('config.utils')['toggle-test-file']()<cr>")
