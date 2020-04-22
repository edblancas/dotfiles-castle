" vim: fdm=marker

" Plugins {{{1
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'

Plug 'altercation/vim-colors-solarized'
Plug 'KeitaNakamura/neodark.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'nikitavoloboev/vim-night-blue'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-abolish'
Plug 'jtratner/vim-flavored-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-tbone'
Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-arpeggio'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/vim-easy-align'

call plug#end()
"}}}

" Config {{{1
" Personal preferences not set by sensible.vim
set showmode
set hidden
set foldmethod=syntax
set tabstop=4 expandtab shiftwidth=4
" No autowrap long lines
set formatoptions-=t    
set wildmode=list:longest,full
set ignorecase
set smartcase
set number
set hlsearch
set wrap
set nobackup
set nowritebackup
set noswapfile
set mouse=a
set showmatch
set cursorline
"set relativenumber
set colorcolumn=100
set vb t_vb=
set scrolloff=3
set clipboard=unnamed
set clipboard+=unnamedplus
set pastetoggle=<F2>
nnoremap <silent> <F2> :set invpaste paste?<CR>
let &t_SI="\<Esc>]50;CursorShape=1\x7"
let &t_EI="\<Esc>]50;CursorShape=0\x7"
set shell=zsh
set t_Co=256
let &showbreak="↳"
set breakindent
set breakindentopt=shift:4,sbr
set listchars=tab:▸–,trail:·,nbsp:¬,eol:<
set showtabline=2
set guioptions-=e
set laststatus=2
set statusline=[%n]\ %f\ %m%y%r%h%w%=%-35.(%{&fenc==\"\"?&enc:&fenc}\ [%{&ff}]\ [%L,%p%%]\ [%l,%c%V]\ %)%P
let mapleader = ","
nnoremap Q <Nop>
nnoremap <Leader>w :w<Enter>
" For display spechial chars, when using with :set list
let g:solarized_visibility="low"
au BufRead,BufNewFile *.log* set filetype=text
let g:xml_syntax_folding=1

" True Colour
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Color Scheme
set background=dark

let g:solarized_visibility="low"
let g:solarized_termtrans=1
"colorscheme solarized

let g:solarized_term_italics=1
"colorscheme solarized8

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
"colorscheme gruvbox

colorscheme dracula
" }}}

" netrw like NERDTree {{{1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
nnoremap <D-1> :Lexplore<CR>
nnoremap <Leader>1 :Lexplore<CR>
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Lexplore
"augroup END
" }}}

" Visual line repeat {{{1
xnoremap . :normal .<CR>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
" }}}

" Smash Escape {{{1
call arpeggio#map('i', '', 0, 'jk', '<Esc>')
" }}}

" Custom mappings and functions {{{1
function! MeGetFilePath()
    let @+ = expand("%:p")
    let @* = expand("%:p")
endfunction
" }}}

" ag & ack.vim {{{1
nnoremap K :AckWindow! "\b<C-R><C-W>\b"<CR>
nnoremap \ :AckWindow!<Space>
nnoremap <Leader>a :Ack<Space>
" }}}

" Semicolon & colon {{{1
inoremap ;<cr> <end>;<cr>
inoremap .<cr> <end>.
inoremap ;;<cr> <down><end>;<cr>
inoremap ..<cr> <down><end>.
" }}}

" From tpope .vimrc {{{1
if has("eval")
  function! SL(function)
      if exists('*'.a:function)
          return ' '.call(a:function,[])
      else
          return ''
      endif
  endfunction
endif
" }}}

" Flagship {{{1
" Quit the defaul showing Vim GUI server name
let g:tabprefix=''
augroup flagship_me
    autocmd!
    autocmd User Flags call Hoist("buffer", "%{&ignorecase ? '[IC]' : ''}")
augroup END
call flagship#setup()
" }}}

" File mappings {{{1
" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
" }}}
