(local {: autoload} (require :nfnl.module))
(local str (autoload :nfnl.string))
(local nvim (autoload :nvim))
(local core (autoload :nfnl.core))

;refresh changed content
(nvim.ex.autocmd "FocusGained,BufEnter" "*" ":checktime")

;lua tabsize
(nvim.ex.autocmd "FileType" "lua" "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

;fennel tabsize
(nvim.ex.autocmd "FileType" "fennel" "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

;clojure tabsize
(nvim.ex.autocmd "FileType" "clojure" "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

;typescript tabsize
(nvim.ex.autocmd "FileType" "typescript" "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

(nvim.ex.autocmd "BufRead,BufNewFile" "*.log" "set filetype=text")

(nvim.ex.autocmd "BufRead,BufNewFile" "README" "set filetype=markdown")

;(nvim.ex.autocmd "BufRead,BufEnter" "conjure-log-*" ":lua require 'util.turn-off-diagnostics'.turn-off-diagnostics-buffer()")

;don't wrap lines
(nvim.ex.set :nowrap)

(set nvim.o.mouse "a")

;sets a nvim global options
(let [options
      {:encoding "utf-8"
       :spelllang "en_us"
       :errorbells true
       :backup false
       :swapfile false
       :showmode false
       :relativenumber true
       ;settings needed for cmp autocompletion
       :completeopt "menuone,noselect"
       ;turn on the wild menu, auto complete for commands in command line
       :wildmenu true
       :wildignore "*/tmp/*,*.so,*.swp,*.zip"
       ;case insensitive search
       :ignorecase true
       ;smart search case
       :smartcase true
       ;shared clipboard with os
       :clipboard "unnamedplus"
       ;show invisible characters
       :list false
       :listchars (str.join "," ["tab:▶-" "trail:•" "extends:»" "precedes:«" "eol:¬"])
       ;tabs is space
       :expandtab true
       ;tab/indent size
       :tabstop 4
       :shiftwidth 4
       :softtabstop 4
       ;persistent undo
       :undofile true
       ;open new horizontal panes on down pane
       :splitbelow true
       ;open new vertical panes on right pane
       :splitright true
       ;enable highlighting search
       :hlsearch true
       ;"number" makes signcolumn always one column with signs and linenumber
       ;"yes" makes signcolumn for both signs and linenumber
       :signcolumn "yes"
       :foldmethod "syntax"
       :foldlevel 1
       :shell "zsh"
       ;when using wrap
       :showbreak "↳"
       :breakindent true
       :breakindentopt "shift:4,sbr"
       :cursorline true}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

{}

