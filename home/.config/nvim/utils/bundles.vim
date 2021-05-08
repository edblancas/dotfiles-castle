" vim: fdm=marker

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" INDISPENSABLE STUFF {{{1
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
Plug 'mileszs/ack.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-arpeggio'
" }}}

" AUTOCOMPLETE STUFF {{{1
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}

" COLOR SCHEMES {{{1
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'connorholyday/vim-snazzy'
Plug 'dracula/vim', { 'as': 'dracula' }
" }}}

" CLOJURE {{{1
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}
Plug 'junegunn/rainbow_parentheses.vim'
" }}} 

" MARKDOWN STUFF {{{1
Plug 'jtratner/vim-flavored-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
" }}}

" IDE STUFF {{{1
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
" }}}

" Javascript {{{1
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" }}}

" OTHER STUFF {{{1
Plug 'tpope/vim-abolish'
Plug 'bootleq/ShowMarks'
Plug 'majutsushi/tagbar'
Plug 'ekalinin/Dockerfile.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
" }}}

" TMUX {{{1
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
" }}}

" SUBLIME LIKE {{{1
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
" }}}

call plug#end()
