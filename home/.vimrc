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

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-abolish'
Plug 'jtratner/vim-flavored-markdown'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-tbone'
Plug 'benmills/vimux'

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
set relativenumber
set colorcolumn=120
set vb t_vb=
set scrolloff=3
set clipboard=unnamed
set clipboard+=unnamedplus
set pastetoggle=<F2>
nnoremap <silent> <F2> :set invpaste paste?<CR>
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set shell=zsh
set t_Co=256
let &showbreak = "↳"
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
colorscheme solarized
set background=dark
" For display spechial chars, when using with :set list
let g:solarized_visibility = "low"
au BufRead,BufNewFile *.log* set filetype=text
let g:xml_syntax_folding=1
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
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>
" }}}

" Custom mappings and functions {{{1
imap <C-d> <C-o>diw
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
    autocmd User Flags call Hoist("window", "SyntasticStatuslineFlag")
augroup END
call flagship#setup()
" }}}
