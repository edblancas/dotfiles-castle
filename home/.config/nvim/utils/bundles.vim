" vim: fdm=marker
filetype off                 

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" INDISPENSABLE STUFF {{{1
"Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitMate'
Plugin 'godlygeek/tabular'
Plugin 'chrisbra/NrrwRgn'
Plugin 'kien/ctrlp.vim'
Plugin 'd11wtq/ctrlp_bdelete.vim'
"Plugin 'svermeulen/vim-easyclip'

Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-function'

Plugin 'mileszs/ack.vim'

" }}}

" AUTOCOMPLETE STUFF {{{1
" Require +lua
" Plugin 'Shougo/neocomplete.vim'
" Insted I just use basic autocomplete plugins
Plugin 'AutoComplPop'
Plugin 'ervandew/supertab'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'honza/vim-snippets'

" }}}

" COLOR SCHEMES {{{1
Plugin 'AfterColors.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'nelstrom/vim-mac-classic-theme'

" }}}

" MARKDOWN STUFF {{{1
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'tpope/vim-markdown'
Plugin 'elzr/vim-json'

" }}}

" OTHER STUFF {{{1
Plugin 'tpope/vim-abolish'  "unix only stuff
Plugin 'tpope/vim-eunuch'   "search and stuff
"Plugin 'bling/vim-airline'
Plugin 'bootleq/ShowMarks'
Plugin 'tpope/vim-flagship'

Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'

Plugin 'gregsexton/gitv'
"Plugin 'airblade/vim-gitgutter'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'wikitopian/hardmode'
Plugin 'majutsushi/tagbar'
Plugin 'mbbill/undotree'
"Plugin 'myusuf3/numbers.vim'
"Plugin 'Yggdroot/indentLine'
"Plugin 'Lokaltog/vim-easymotion'

Plugin 'derekwyatt/vim-scala'
Plugin 'udalov/kotlin-vim'
" }}}

call vundle#end()            
filetype plugin indent on   
