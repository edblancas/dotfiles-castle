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
Plug 'tpope/vim-jdaddy'
Plug 'jtratner/vim-flavored-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-arpeggio'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'

Plug 'junegunn/vim-easy-align'

Plug 'preservim/nerdtree'

call plug#end()
"}}}

" Config {{{1
" Personal preferences not set by sensible.vim
set showmode
set foldmethod=syntax
set tabstop=4 expandtab shiftwidth=4
set completeopt=menuone,noselect
set ignorecase
set smartcase
set relativenumber
set hlsearch
set nobackup
set noswapfile
set mouse=a
set showmatch
set colorcolumn=80
set vb t_vb=
set clipboard=unnamed
set clipboard+=unnamedplus
set nowrap
set pastetoggle=<F2>
nnoremap <silent> <F2> :set invpaste paste?<CR>
" fix cursor shape change when insert mode when in tmux, only for vim, nvim
" works fine
" https://vi.stackexchange.com/questions/3379/cursor-shape-under-vim-tmux
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif
set shell=zsh
set t_Co=256
let &showbreak="↳"
set breakindent
set breakindentopt=shift:4,sbr
set listchars=tab:▸–,trail:·,nbsp:¬,eol:<
set statusline=[%n]\ %f\ %m%y%r%h%w%=%-35.(%{&fenc==\"\"?&enc:&fenc}\ [%{&ff}]\ [%L,%p%%]\ [%l,%c%V]\ %)%P
let mapleader = " "
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

" cursor line in insert mode {{{1
" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" }}}

" NERDTree idea like keymap {{{1
nnoremap <Leader>1 :NERDTreeToggle<CR>
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :NERDTreeToggle
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
