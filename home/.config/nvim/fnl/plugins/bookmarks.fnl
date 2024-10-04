[
 {1 :crusj/bookmarks.nvim
 :branch :main
 :dependencies [:nvim-tree/nvim-web-devicons]
 :config (fn []
   (let [bk (require :bookmarks)
         tl (require :telescope)]
     (bk.setup {:keymap {:toggle "<D-2>"
                         :add "<F3>"}})
     (tl.load_extension :bookmarks)
     (vim.keymap.set [:n :i] "<D-2>" "<cmd>lua require('bookmarks').toggle_bookmarks()<cr>")
     (vim.keymap.set [:n :i] "<F3>" "<cmd>lua require('bookmarks').add_bookmarks()<cr>")))}
 ]
