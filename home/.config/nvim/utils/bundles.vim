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
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdcommenter'
"Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'chrisbra/NrrwRgn'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
"Plug 'svermeulen/vim-easyclip'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'

Plug 'mileszs/ack.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" }}}

" AUTOCOMPLETE STUFF {{{1
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" }}}

" COLOR SCHEMES {{{1
Plug 'AfterColors.vim'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'noahfrederick/vim-hemisu'
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

" OTHER STUFF {{{1
Plug 'tpope/vim-abolish'  "unix only stuff
Plug 'tpope/vim-eunuch'   "search and stuff
"Plug 'bling/vim-airline'
Plug 'bootleq/ShowMarks'
Plug 'tpope/vim-flagship'

Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

Plug 'gregsexton/gitv'
"Plug 'airblade/vim-gitgutter'

Plug 'terryma/vim-multiple-cursors'
Plug 'wikitopian/hardmode'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
"Plug 'myusuf3/numbers.vim'
"Plug 'Yggdroot/indentLine'
"Plug 'Lokaltog/vim-easymotion'

Plug 'derekwyatt/vim-scala'
Plug 'udalov/kotlin-vim'
Plug 'dag/vim-fish'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'scrooloose/syntastic'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" }}}

call plug#end()
