execute pathogen#infect()
syntax on
filetype plugin indent on

set number

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

map <C-t> :NERDTreeToggle<CR>
map <C-o> :bn<CR>
map <C-i> :bp<CR>
map <C-d> :BD<CR>

map <C-c> :r!cite<CR>

map <C-e> :w<CR>:!latexmk -pdf -shell-escape<CR>

set expandtab
set shiftwidth=2
set softtabstop=2

set tw=80

set mouse=a
set clipboard=unnamed

autocmd StdinReadPre * let s:std_in=1

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:NERDTreeWinSize=60
map <C-b> :CtrlPBuffer<CR>

autocmd BufEnter * :syntax sync fromstart
set hidden
au FileType gitcommit set tw=72

let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

map <Leader>c :wq<CR>:Git push<CR>

set cursorline
hi CursorLine cterm=NONE ctermbg=242 guifg=#000000

let g:vimroom_sidebar_height=0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_extensions = ['line']

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
set termguicolors " if you want to run vim in a terminal
colorscheme gruvbox

set updatetime=250

au CompleteDone * pclose

let g:gitgutter_sign_column_always = 1
highlight SignColumn guibg=#292929
highlight StatusLine guifg=#292929 guibg=#666666

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
