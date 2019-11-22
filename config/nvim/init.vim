if has('nvim')
  call plug#begin('$HOME/.local/share/nvim/plugged')

  Plug 'kien/ctrlp.vim'
  Plug 'qpkorr/vim-bufkill'
  Plug 'ap/vim-buftabline'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'morhetz/gruvbox'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'derekwyatt/vim-scala'
  Plug 'lervag/vimtex'
  Plug 'tpope/vim-surround'
  Plug 'rhysd/vim-clang-format'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'wlangstroth/vim-racket'

  " Plug 'autozimu/LanguageClient-neovim', {
  "   \ 'branch': 'next',
  "   \ 'do': 'bash install.sh',
  "   \ }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'Shougo/neosnippet'
  " Plug 'Shougo/neosnippet-snippets'
  " Plug 'Valloric/YouCompleteMe'
  " Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

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
 
set expandtab
set shiftwidth=2
set softtabstop=2
 
set textwidth=80
 
set mouse=a
set clipboard=unnamedplus
 
map <C-b> :CtrlPBuffer<CR>
 
autocmd BufEnter * :syntax sync fromstart
set hidden
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
let g:vimtex_latexmk_options = '-pdf -shell-escape -verbose -file-line-error -synctex=1 -interaction=nonstopmode'

augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
  augroup END

" let g:LanguageClient_serverCommands = {
" \ 'cpp': ['cquery', '--log-file=/tmp/cq.log']                                                                                                                                                                              
" \ }
" let g:LanguageClient_loadSettings = 1
" let g:LanguageClient_settingsPath = '/home/bruce/.config/nvim/settings.json'
let g:deoplete#enable_at_startup = 1

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#auto_format = 1

set matchpairs+=<:>

map <C-n> :!make<CR>
