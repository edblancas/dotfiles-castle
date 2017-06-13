" vim: fdm=marker

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" INDISPENSABLE STUFF {{{1
"Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-jdaddy'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-vinegar'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
Plug 'mileszs/ack.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'
" }}}

" AUTOCOMPLETE STUFF {{{1
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" }}}

" COLOR SCHEMES {{{1
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'nelstrom/vim-mac-classic-theme'
" }}}

" MARKDOWN STUFF {{{1
Plug 'jtratner/vim-flavored-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
" }}}

" TypeScript STUFF {{{1
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/syntastic'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" }}}

" Ruby STUFF {{{1
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-rails'
" }}}

" OTHER STUFF {{{1
Plug 'tpope/vim-abolish'
Plug 'bootleq/ShowMarks'
Plug 'terryma/vim-multiple-cursors'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'benmills/vimux'
Plug 'ekalinin/Dockerfile.vim'
"Plug 'Yggdroot/indentLine'
"Plug 'derekwyatt/vim-scala'
"Plug 'udalov/kotlin-vim'
" }}}

call plug#end()
