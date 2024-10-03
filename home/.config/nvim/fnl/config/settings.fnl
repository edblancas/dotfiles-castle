(local {: autoload} (require :nfnl.module))
(local str (autoload :nfnl.string))
(local nvim (autoload :nvim))
(local core (autoload :nfnl.core))

;refresh changed content
(nvim.ex.autocmd "FocusGained,BufEnter" "*" ":checktime")

;lua tabsize
(nvim.ex.autocmd "FileType" "lua" "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

;fennel tabsize
(nvim.ex.autocmd "FileType" 
                 "clojure,fennel,typescript,typescriptreact"
                 "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab")

;disable aoutoformat at textwidth, remove t option
(nvim.ex.autocmd "FileType" "python" "setlocal formatoptions-=t")

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
       :foldlevel 1
       :shell "zsh"
       ;when using wrap
       :showbreak "↳"
       :textwidth 80
       :breakindent true
       :breakindentopt "shift:4,sbr"
       :cursorline true
       :foldenable false
       :foldmethod "expr"
       :foldexpr "v:lua.vim.treesitter.foldexpr()"
       :foldtext ""}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

{}

