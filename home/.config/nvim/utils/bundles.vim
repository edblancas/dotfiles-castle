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
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-commentary'
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
Plug 'kana/vim-arpeggio'
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
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'connorholyday/vim-snazzy'
" }}}

" MARKDOWN STUFF {{{1
Plug 'jtratner/vim-flavored-markdown'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-markdown'
Plug 'elzr/vim-json'
" }}}

" IDE STUFF {{{1
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'
" }}}

" Javascript {{{1
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }
Plug 'valloric/MatchTagAlways'
" Currently, es6 version of snippets is available in es6 branch only
Plug 'letientai299/vim-react-snippets', { 'branch': 'es6' }
Plug 'mattn/emmet-vim'
" }}}

" OTHER STUFF {{{1
Plug 'tpope/vim-abolish'
Plug 'bootleq/ShowMarks'
Plug 'terryma/vim-multiple-cursors'
Plug 'majutsushi/tagbar'
Plug 'ekalinin/Dockerfile.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" }}}

" TMUX {{{1
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
" }}}

" SUBLIME LIKE {{{1
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
" }}}

call plug#end()
