(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))
(local core (autoload :nfnl.core))

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})

;from sensible.vim
(nvim.set_keymap :n 
                 :<leader><space> 
                 ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>" 
                 {:noremap true :desc "nohlsearch/diffupdate"})

;duplicate currents panel in a new tab
(nvim.set_keymap :n :<C-w>T ":tab split<CR>" {:noremap true :silent true})

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
; move next/previous search occurrence and center
; and opend folds
(vim.keymap.set "n" "n" "nzzzv")
(vim.keymap.set "n" "N" "Nzzzv")

;when selected some text and exec, then replace
;the text with the text in the register and
;mantain this text in the register
;previously the text replaced will be in the register
;x for only visual mode
;s for only select mode
;v for both visual and select mode
(vim.keymap.set "x" "<leader>p" "\"_dP")

;delete and text discarded
(vim.keymap.set [:n :v] "<leader>d" "\"_d")

;quickfix/location list
(vim.keymap.set "n" "<C-k>" "<cmd>cnext<CR>zz")
(vim.keymap.set "n" "<C-j>" "<cmd>cprev<CR>zz")
(vim.keymap.set "n" "<leader>k" "<cmd>lnext<CR>zz")
(vim.keymap.set "n" "<leader>j" "<cmd>lprev<CR>zz")

(vim.keymap.set [:n :v :i] "<D-s>" "<cmd>w<CR>")
(vim.keymap.set [:n :v :i] "<D-M-s>" "<cmd>wall<CR>")

(vim.keymap.set [:n] "<leader>]" ":bn<cr>")
(vim.keymap.set [:n] "<leader>[" ":bp<cr>")

;in replace just change whats inside <>
;like rename tags
(vim.keymap.set :n "<leader>s" ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>" {:desc "Rename <tag>"})

(vim.keymap.set "n" "<leader>x" "<cmd>!chmod +x %<CR>" {:silent true})

(vim.keymap.set [:n] "<F10>" "<C-w>|")
(vim.keymap.set [:n] "<D-F10>" "<C-w>_")

;(vim.keymap.set [:n :i] "<F18>" "<cmd>lua require('config.utils')['toggle-test-file']()<cr>")

;unmap F1 help
(vim.keymap.set [:n :i] "<F1>" "<nop>")

;mimic vim-vinegar
;https://github.com/stevearc/oil.nvim?tab=readme-ov-file#quick-start
(vim.keymap.set [:n] "-" "<CMD>Oil<CR>" { :desc "Open parent directory"})

(vim.api.nvim_create_user_command 
  "Format" 
  (fn [args]
    (var range nil)
    (let [conform (require :conform)]
      (if (not= args.count -1)
          (do
            (local end_line (. (vim.api.nvim_buf_get_lines 0 (- args.line2 1) args.line2 true) 1))
            (set range {:start [args.line1 0]
                        :end [args.line2 (end_line:len)]})))
      (conform.format {:async true
                           :lsp_format :fallback
                           :range range})))
  {:range true})

(vim.keymap.set [:n :v :i] "<M-D-l>" "<CMD>Format<CR>" {:desc "Format with comform"})

;copy the path of the current file from the cwd to the + register
(vim.api.nvim_create_user_command 
  "CopyFilePathProject"
  (fn [_]
    (let [cwd (vim.fn.getcwd)
          folder_name (vim.fn.fnamemodify cwd ":t")
          file-path (vim.fn.expand "%")]
      (vim.fn.setreg "+" (.. folder_name "/" file-path))))
  {})

;copy the absolut path of the current file to + register
(vim.api.nvim_create_user_command 
  "CopyFilePath"
  (fn [_]
    (let [cwd (vim.fn.getcwd)
          folder_name (vim.fn.fnamemodify cwd ":t")
          file-path (vim.fn.expand "%")]
      (vim.fn.setreg "+" (.. folder_name "/" file-path))))
  {})

(vim.api.nvim_create_autocmd "FileType"
  {:pattern ["typescript" "typescriptreact"]
   :callback (fn []
               (vim.keymap.set :n :<C-M-o> "<cmd>OptimizeImports<cr>" {:noremap true}))})

(vim.api.nvim_create_autocmd "FileType"
 {:pattern "python"
  :callback (fn []
               (vim.keymap.set :n :<C-M-o> "<cmd>PyrightOrganizeImports<cr>" {:noremap true}))})

;NOTE: Ensures that when exiting NeoVim, Zellij returns to normal mode
(vim.api.nvim_create_autocmd "VimLeave" 
  {:pattern "*"
    :command "silent !zellij action switch-mode normal"})

(vim.keymap.set [:n :v :i] "<C-C>" "<CMD>cclose<CR>" {:desc "Close quickfix"})

(vim.keymap.set [:n :i] "<F1>" ":lua vim.lsp.buf.hover()<CR>" {:desc "Hover doc"})

(vim.api.nvim_create_user_command
  "OpenNotes"
    (fn  []
      (let [get-notes-root
            (fn []
              (let [dot-git-path (vim.fn.finddir "~/Documents/dev/notes/" ".;")]
                (vim.fn.fnamemodify dot-git-path ":h")))
            tel (require "telescope.builtin")]
        (tel.find_files {:cwd (get-notes-root)
                        :prompt_title "Search Notes"
                        :find_command ["rg" "--files" "--glob" "*.md" 
                                         "--glob" "*.markdown" "--glob" "*.txt" "--glob" "*.org"]
})))
    {})

(vim.keymap.set [:n :i] "<M-D-n>" "<cmd>OpenNotes<cr>" {:desc "Open notes"})

(vim.api.nvim_create_user_command
  "GrepNotes"
    (fn  []
      (let [get-notes-root
            (fn []
              (let [dot-git-path (vim.fn.finddir "~/Documents/dev/notes/" ".;")]
                (vim.fn.fnamemodify dot-git-path ":h")))
            tel (require "telescope.builtin")]
        (tel.live_grep {:cwd (get-notes-root)
                        :prompt_title "Grep Notes"
                        :find_command ["rg" "--files" "--glob" "*.md" 
                                         "--glob" "*.markdown" "--glob" "*.txt" "--glob" "*.org"]})))
    {})

(vim.keymap.set [:n :i] "<S-D-n>" "<cmd>GrepNotes<cr>" {:desc "Grep notes"})

(vim.api.nvim_create_user_command
  "CreateNote"
  (fn [_]
    (let [file-name (vim.fn.input "Enter the note name: ")
          notes-dir "~/Documents/notes/"
          full-path (vim.fn.expand (.. notes-dir file-name))]
      (vim.cmd (.. "edit " full-path))
      (vim.cmd "write")))
  {})

;from tjdevires config
;https://github.com/tjdevries/config.nvim/blob/master/plugin/terminal.lua
;Easily hit escape in terminal mode.
(vim.keymap.set [:t] "<esc><esc>" "<c-\\><c-n>")

(var job-id nil)
(var term-buf nil)
; Toggle terminal keybind
(vim.keymap.set [:n]
                "<leader>tt"
                (fn []
                  (if (and job-id
                           (vim.api.nvim_buf_is_valid term-buf))
                    ; If the terminal exists, toggle its visibility
                    (let [term-win (vim.fn.bufwinid term-buf)]
                      (if (>= term-win 0)
                        (vim.api.nvim_win_close term-win true)
                        (do
                          (vim.cmd.split)
                          (vim.cmd.buffer term-buf)
                          (vim.api.nvim_win_set_height 0 15))))
                    ; Otherwise, create a new terminal
                    (do
                      (vim.cmd.vnew)
                      (vim.cmd.term)
                      (vim.cmd.wincmd "J")
                      (vim.api.nvim_win_set_height 0 15)
                      (set term-buf (vim.api.nvim_get_current_buf))
                      (set job-id vim.bo.channel))))
                {:desc "Toggle terminal"})

(vim.keymap.set [:n] 
                "<leader>mm" 
                (fn []
                  (vim.fn.chansend job-id ["npm run create-on-time-challenge\r\n"]))
                {:desc "npm run create-on-time-challenge"})

{}
