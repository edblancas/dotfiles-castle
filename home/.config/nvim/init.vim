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
set relativenumber
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
" Yank from " to + register an viceversa, for linux
set clipboard+=unnamedplus

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
colorscheme solarized
set background=dark
" For display spechial chars, when using with :set list
let g:solarized_visibility = "low"

set showtabline=2
set guioptions-=e
set laststatus=2
set statusline=[%n]\ %f\ %m%y%r%h%w%=%-35.(%{&fenc==\"\"?&enc:&fenc}\ [%{&ff}]\ [%L,%p%%]\ [%l,%c%V]\ %)%P

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
map <Leader>d :bd<CR>
map <Leader>D :bd!<CR>
map <Leader>W :w \| bd<CR>
map <Leader>h :hide<CR>

nnoremap <leader>se <C-w><C-v><C-l>:e $MYVIMRC<CR>
nnoremap <Leader>sb <C-w><C-v><C-l>:e ~/.config/nvim/utils/bundles.vim<CR>
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
silent! nnoremap <silent> TT :!~/.config/nvim/utils/ctags-proj.sh<CR>

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

" Toggle relativenumber {{{2
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

" Clashes with multiple cursors
map <Leader>nt :call NumberToggle()<CR>
"}}}

" Markdown {{{2
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
    autocmd FileType ghmarkdown,vim let b:loaded_delimitMate=1
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

" http://superuser.com/questions/649714/can-i-get-the-vim-ctrlp-plugin-to-ignore-a-specific-folder-in-one-project
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

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

" UltiSnips {{2
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<C-j>"

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

" fzf.vim {{2
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=0 ctermbg=11
  highlight fzf2 ctermfg=0 ctermbg=11
  highlight fzf3 ctermfg=0 ctermbg=11
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Tsuquyomi {{2
" syntastic for displaying syntax and semantics errors instead of vim's
" default quickfix window
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

" Syntastic {{2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['python', 'typescript'],
                           \ 'passive_filetypes': ['java'] }
" Flagship {{{2
" Quit the defaul showing Vim GUI server name
let g:tabprefix=''

" For not acumulate autocmds
" http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
augroup flagship_me
    autocmd!
    autocmd User Flags call Hoist("buffer", "%{&ignorecase ? '[IC]' : ''}")
    autocmd User Flags call Hoist("window", "SyntasticStatuslineFlag")
augroup END

" For when reload the vimrc reload fugitive default in flagship
call flagship#setup()

" YCM {{2
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

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
" }}}

" Semicolon & colon
inoremap ;<cr> <end>;<cr>
inoremap .<cr> <end>.
inoremap ;;<cr> <down><end>;<cr>
inoremap ..<cr> <down><end>.
