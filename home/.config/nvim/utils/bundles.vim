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
Plug 'scrooloose/nerdcommenter'
"Plug 'tpope/vim-vinegar'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'chrisbra/NrrwRgn'
Plug 'kien/ctrlp.vim'
Plug 'd11wtq/ctrlp_bdelete.vim'
"Plug 'svermeulen/vim-easyclip'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'

Plug 'mileszs/ack.vim'

" }}}

" AUTOCOMPLETE STUFF {{{1
" Require +lua
" Plug 'Shougo/neocomplete.vim'
" Insted I just use basic autocomplete plugins
"Plug 'AutoComplPop'
Plug 'ervandew/supertab'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
" Most complex AUTOCOMPLETE
Plug 'Shougo/deoplete.nvim'

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
" }}}

call plug#end()
