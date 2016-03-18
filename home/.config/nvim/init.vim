" vim: fdm=marker

source ~/.config/nvim/utils/bundles.vim
source ~/.config/nvim/utils/watch_for_changes.vim

" Personal preferences not set by sensible.vim
set showmode " Por que vim-airline muestra el modo en el que estamos
set hidden
set foldmethod=syntax
set tabstop=4 expandtab shiftwidth=4
set formatoptions-=t    " No autowrap long lines
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
" Not compatible with nvim?
"set encoding=utf-8
set colorcolumn=100
" Es el valor que toma en cuenta gq, pero lo hace automatico si se deja
" set textwidth=100
set vb t_vb=
set scrolloff=3

set pastetoggle=<F2>
nnoremap <silent> <F2> :set invpaste paste?<CR>
" Yank from " to * register an viceversa
set clipboard=unnamed

" Otas opciones
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set shell=zsh
set t_Co=256
let &showbreak = "↳"
set breakindent
set breakindentopt=shift:4,sbr
set listchars=tab:▸–,trail:·,nbsp:¬,eol:<

" Color Scheme
colorscheme Tomorrow
"set background=light
"let g:solarized_visibility = "low" 

set showtabline=2
set guioptions-=e
set laststatus=2
set statusline=[%n]\ %f\ %m%y%r%h%w%{SL('fugitive#statusline')}\ %=%-35.(%{&fenc==\"\"?&enc:&fenc}[%{&ff}]\ [%L,%p%%]\ [%l,%c%V]\ %)%P

" Para los logs
au BufRead,BufNewFile *.log* set filetype=text
" Indent xml
let g:xml_syntax_folding=1

" Mappings {{{1
" Override defaults {{{2
let mapleader = ","
nnoremap Q <Nop>
nnoremap <space> za
nnoremap j gj
nnoremap k gk
nnoremap <Leader>w :w<Enter>

" File opening {{{2
cnoremap <expr> %%  getcmdtype() == ':' ? fnameescape(expand('%:h')).'/' : '%%'

map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

map <Leader><Tab> :b#<CR>
map <Leader>n :new<CR>
map <Leader>d :bd<CR>
map <Leader>D :bd!<CR>
map <Leader>W :w \| bd<CR>
map <Leader>h :hide<CR>

nnoremap <leader>se <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <Leader>sb <C-w><C-v><C-l>:e ~/.nvim/utils/bundles.vim<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Fix the & command in normal+visual modes {{{2
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" Strip trailing whitespace and text operations {{{2
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap <silent> <S-Space> :call Preserve("%s/\\s\\+$//e")<CR>

" Reformat paragraph to textwidth
nnoremap <leader>q gqip

" Visual line repeat {{{2
xnoremap . :normal .<CR>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Ctags {{{2
silent! nnoremap <silent> TT :!~/.nvim/utils/ctags-proj.sh<CR>

" Smash Escape {{{2
"inoremap <esc> <nop>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>

" Custom mappings and functions {{{2
" Delete a word to the right
imap <C-d> <C-o>diw

" Override the read-only permissions
cmap w!! %!sudo tee > /dev/null %

" Copy the path of the actual file
function! MeGetFilePath()
    let @+ = expand("%:p")
    let @* = expand("%:p")
endfunction

" Force yourself to stop using arrow keys
noremap   <Up>     <Nop>
noremap   <Down>   <Nop>
noremap   <Left>   <Nop>
noremap   <Right>  <Nop>
inoremap  <Up>     <Nop>
inoremap  <Down>   <Nop>
inoremap  <Left>   <Nop>
inoremap  <Right>  <Nop>

" Quit <F1> for showing the help.txt
noremap <F1>    <Nop>
inoremap <F1>   <Nop>

" Experimental mappings {{{2
nnoremap g" /\v<<C-r>"><CR>

command! Path :call EchoPath()
function! EchoPath()
  echo join(split(&path, ","), "\n")
endfunction

command! TagFiles :call EchoTags()
function! EchoTags()
  echo join(split(&tags, ","), "\n")
endfunction

nmap cp <Plug>TransposeCharacters
nnoremap  <Plug>TransposeCharacters xp
\:call repeat#set("\<Plug>TransposeCharacters")<CR>

" Plugin configuration {{{1
" Markdown {{{2
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
    autocmd FileType markdown,vim let b:loaded_delimitMate=1
augroup END
let g:vim_markdown_folding_disabled=1

let g:instant_markdown_autostart = 0

" CtrlP {{{2
silent! nnoremap <unique> <silent> <Leader>p :CtrlP<CR>
silent! nnoremap <unique> <silent> <Leader>b :CtrlPBuffer<CR>
silent! nnoremap <unique> <silent> <Leader>T :CtrlPTag<CR>
silent! nnoremap <unique> <silent> <Leader>t :CtrlPBufTag<CR>
silent! nnoremap <unique> <silent> <Leader>r :CtrlPMRUFiles<CR>
silent! nnoremap <unique> <silent> <Leader>o :CtrlPBookmarkDir<CR>

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
    \ 'link': 'some_bad_symbolic_links',
    \ }

let g:ctrlp_map = ''
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['buffertag', 'bookmarkdir']
let g:ctrlp_working_path_mode = 0

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_match_window = 'max:30'

call ctrlp_bdelete#init()

" Airline {{{2
let g:airline_powerline_fonts = 1
let g:airline_section_warning=''
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_inactive_collapse=0

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'tomorrow'
    for colors in values(a:palette.inactive)
      let colors[2] = 102
    endfor
  endif
endfunction

" neocomplete {{{2
"let g:acp_enableAtStartup = 0
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_auto_delimiter = 1
"let g:neocomplete#max_list = 30
"let g:neocomplete#enable_auto_select = 1
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"            \ 'default' : '',
"            \ 'vimshell' : $HOME.'/.vimshell_hist',
"            \ 'scheme' : $HOME.'/.gosh_completions'
"            \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"imap <expr> <TAB> pumvisible() ? neocomplete#close_popup() : "\<TAB>"
"inoremap <expr> <ESC>  pumvisible() ? neocomplete#cancel_popup() : "\<ESC>"
"inoremap <expr> <CR> delimitMate#WithinEmptyPair() ?
"          \ "\<C-R>=delimitMate#ExpandReturn()\<CR>" :
"          \ neocomplete#cancel_popup() . '<CR>'
"inoremap <expr> <BS> delimitMate#WithinEmptyPair() ?
"          \ "\<C-R>=delimitMate#BS()\<CR>" :
"          \ neocomplete#smart_close_popup() . '<BS>'
"
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" neosnippet {{{2
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.nvim/bundle/vim-snippets/snippets'

" Tabular {{{2
" Invoke by <leader>= alignment-character
nnoremap <silent> <leader>= :call g:Tabular(1)<CR>
xnoremap <silent> <leader>= :call g:Tabular(0)<CR>
function! g:Tabular(ignore_range) range
    let c = getchar()
    let c = nr2char(c)
    if a:ignore_range == 0
        exec printf('%d,%dTabularize /%s', a:firstline, a:lastline, c)
    else
        exec printf('Tabularize /%s', c)
    endif
endfunction

" Tagbar {{{2
nmap <F8> :TagbarToggle<CR>

" EasyClip {{{2
"nmap <silent> gs <plug>SubstituteOverMotionMap
"nmap gss <plug>SubstituteLine
"xmap gs p
"
"let g:EasyClipUseCutDefaults = 0
"nmap x <Plug>MoveMotionPlug
"xmap x <Plug>MoveMotionXPlug
"nmap xx <Plug>MoveMotionLinePlug

" ag & ack.vim {{{2
"let g:ackprg = 'ag -H --nogroup --nocolor --column'

nnoremap K :AckWindow! "\b<C-R><C-W>\b"<CR>
nnoremap \ :AckWindow!<Space>
nnoremap <Leader>a :Ack<Space>

" UndoTree {{{2
nnoremap <F5> :UndotreeToggle<cr>

" delimitMate {{{2
let delimitMate_expand_cr = 1

" ShowMarks {{{2
let g:showmarks_auto_toggle = 0
let g:showmarks_ignore_type = "h"

" NerdTree {{{2
map <Leader>l :NERDTreeToggle<CR>
map <Leader>L :NERDTree<CR>
map <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" Flagship {{{2
" Quit the defaul showing Vim GUI server name
let g:tabprefix=''


" Commands {{{1
" From tpope .vimrc
if has("eval")
  function! SL(function)
      if exists('*'.a:function)
          return ' '.call(a:function,[])
      else
          return ''
      endif
  endfunction
endif
