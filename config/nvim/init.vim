if has('nvim')
  call plug#begin('$HOME/.local/share/nvim/plugged')

  Plug 'airblade/vim-gitgutter'
  " Plug 'ap/vim-buftabline'
  Plug 'cespare/vim-toml'
  Plug 'derekwyatt/vim-scala'
  Plug 'godlygeek/tabular'
  Plug 'kana/vim-operator-user'
  Plug 'kien/ctrlp.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'lervag/vimtex'
  Plug 'morhetz/gruvbox'
  Plug 'plasticboy/vim-markdown'
  Plug 'qpkorr/vim-bufkill'
  Plug 'rhysd/vim-clang-format'
  Plug 'rust-lang/rust.vim'
  Plug 'tpope/vim-commentary'
  Plug 'rhysd/vim-llvm'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'LnL7/vim-nix'
  Plug 'martinda/Jenkinsfile-vim-syntax'
  Plug 'tell-k/vim-autopep8'

  Plug 'baltoli/k-editor-support', { 'branch': 'markdown-fences', 'rtp': 'vim' }

  call plug#end()
endif

if (has("termguicolors"))
 set termguicolors
endif
set background=dark
colorscheme gruvbox

syntax enable
filetype plugin indent on

set number

map <C-o> :bn<CR>
map <C-i> :bp<CR>
map <C-d> :BD<CR>

map <C-e> :w<CR>:silent !latexmk -pdf -shell-escape -output-directory=$(dirname %) %<CR>:redraw!<CR>

set expandtab
set shiftwidth=2
set softtabstop=2

set tw=80

set mouse=a
set clipboard=unnamedplus

map <C-b> :CtrlPBuffer<CR>

autocmd BufEnter * :syntax sync fromstart
set hidden

au FileType * set tw=80
au FileType gitcommit set tw=72

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

set signcolumn=yes

" "This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

let g:buftabline_numbers=2
nmap <Leader>1 <Plug>BufTabLine.Go(1)
nmap <Leader>2 <Plug>BufTabLine.Go(2)
nmap <Leader>3 <Plug>BufTabLine.Go(3)
nmap <Leader>4 <Plug>BufTabLine.Go(4)
nmap <Leader>5 <Plug>BufTabLine.Go(5)
nmap <Leader>6 <Plug>BufTabLine.Go(6)
nmap <Leader>7 <Plug>BufTabLine.Go(7)
nmap <Leader>8 <Plug>BufTabLine.Go(8)
nmap <Leader>9 <Plug>BufTabLine.Go(9)
nmap <Leader>0 <Plug>BufTabLine.Go(10)

nmap <C-c> :pclose<CR>

let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1

let g:ycm_filetype_blacklist = {
  \ 'markdown' : 1,
  \ 'tex' : 1
  \}

let g:tex_flavor = "latex"
" let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
let g:vimtex_quickfix_open_on_warning = 0

augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
  augroup END

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:rustfmt_autosave = 1

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 1

let g:airline#extensions#tabline#enabled = 1

let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" let g:autopep8_disable_show_diff=1
" augroup pep8
"     autocmd FileType python
"         \ autocmd! BufWritePost <buffer> Autopep8
" augroup END

set inccommand=nosplit

autocmd FileType java ClangFormatAutoDisable
