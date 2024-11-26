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

(local cusmtom-term-open (vim.api.nvim_create_augroup :cusmtom-term-open {}))
(vim.api.nvim_create_autocmd 
  ["TermOpen"] 
  {:desc "Custom terminal config, no line numbers"
   :pattern "*"
   :callback (fn []
               (core.assoc vim.opt_local :number false)
               (core.assoc vim.opt_local :relativenumber false)
               (core.assoc vim.opt_local :scrolloff 0)
               (core.assoc vim.bo :filetype :terminal))
	 :group cusmtom-term-open})

;Automatic toggleing between line number modes
;https://jeffkreeftmeijer.com/vim-number/
;Both absolute and relative line numbers are enabled by default, 
;which produces “hybrid” line numbers. When entering insert mode, 
;relative line numbers are turned off, leaving absolute line numbers 
;turned on. This also happens when the buffer loses focus.
(local numbertoggle (vim.api.nvim_create_augroup :numbertoggle {:clear  true}))
(vim.api.nvim_create_autocmd 
  ["BufEnter" "FocusGained" "InsertLeave" "WinEnter"] 
  {:desc "Set relativenumber if not in insert mode"
   :pattern "*"
	 :command "if &nu && mode() != 'i' | set rnu   | endif"
	 :group numbertoggle})
(vim.api.nvim_create_autocmd 
  ["BufLeave" "FocusLost" "InsertEnter" "WinLeave"] 
  {:desc "Set absolute numbers if in insert mode or lose focus"
   :pattern "*"
	 :command "if &nu                  | set nornu | endif"
	 :group numbertoggle})


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
       :number true
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
       :foldtext "" 
       :colorcolumn "80"}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

;Disable signs globally for diagnostics
(vim.diagnostic.config {
  :signs false 
  :virtual_text false
})

{}

