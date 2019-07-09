" Pluging Start
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
" Plug 'git://git.wincent.com/command-t.git'
Plug 'scrooloose/nerdtree'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" OneDark Theme
Plug 'joshdick/onedark.vim'
" Vim Emmet
Plug 'mattn/emmet-vim'
" Syntastic
Plug 'editorconfig/editorconfig-vim'
" Plug 'vim-syntastic/syntastic'
" Javascript-libraries-sytax.vim
Plug 'othree/javascript-libraries-syntax.vim'
" Surrond vim
Plug 'tpope/vim-surround'
" Nerdtree
Plug 'scrooloose/nerdcommenter'
" Vim signature mark improvement
Plug 'kshenoy/vim-signature'
" Ctrlp fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
" Vim-easy-align
Plug 'junegunn/vim-easy-align'
" Textobj implements
Plug 'kana/vim-textobj-user'
" Textobj entire buffer
Plug 'kana/vim-textobj-entire'
" Multiyple cursors
Plug 'terryma/vim-multiple-cursors'
" javascript-libraries-syntax
Plug 'othree/javascript-libraries-syntax.vim'
" php plug
Plug 'StanAngeloff/php.vim'
" YouCompleteMe
" Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
" Auto Pair
Plug 'jiangmiao/auto-pairs'
Plug 'nelsyeung/twig.vim'
Plug 'jwalton512/vim-blade'
" Initialize plugin system
call plug#end()

nnoremap <Up> :echomsg "use k"<cr>
nnoremap <Down> :echomsg "use j"<cr>
nnoremap <Left> :echomsg "use h"<cr>
nnoremap <Right> :echomsg "use l"<cr>
" buffer short cut
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
map <silent> <C-C> <Esc>
" nohlsearch shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" don't make vim compatible with vi
set nocompatible

set path+=**
" Syntax highlighting
syntax on
" Line numbers
set number nu
" Relative numbers
set relativenumber
" Color the cursorline
set cursorline
" Auto indenting
set autoindent
" Smart indenting
set smartindent
" reload files changed outside vim
set autoread
" Wild menu
set wildmenu
" View cmd
set showcmd
" our <leader> will be the space key
let mapleader=" "
" our <localleader> will be the '-' key
let maplocalleader="-"

"  Font
if has('gui_running')
  set guifont=Hack:h12
endif
" Some basic PSR code style rules
" ts = tabstop; sts = softtabstop; sw = shiftwidth
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype vue setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype php setlocal ts=4 sts=4 sw=4
autocmd Filetype twig setlocal ts=4 sts=4 sw=4

set scrolloff=3
" Use spaces instead to tabs
set expandtab
" No wrap
set nowrap
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
"
" Split windows fast
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>
" Windows Gvim need to reload menu with UTF-8 encoding
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Emmet
" let g:user_emmet_expandabbr_key='<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" NERDTree Settings
map <silent> <C-\> :NERDTreeToggle<cr>
set background=dark
let NERDTreeQuitOnOpen=1

" Airline Settings
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep ='|'
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

" nerdCommenter Settings"
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = { 'php': { 'left': '//'}, 'html': { 'left': '<!--', 'right': '-->'}}

" Ctrlp Settings
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

colorscheme onedark
" Automatically removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
" Vim-easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" Vim multiple cursors
" Multiple cursors
let g:multi_cursor_start_key='<F5>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif

let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
let g:onedark_terminal_italics  = 1

"...
colorscheme onedark

" if has("gui_running")
        " highlight Cursor guifg=black guibg=white
        " highlight iCursor guifg=black guibg=white
        " set guicursor=n-v-c:block-Cursor
        " set guicursor+=i:ver100-iCursor
        " set guicursor+=n-v-c:blinkon0
        " set guicursor+=i:blinkwait1
" endif

"Force cursor styling in nvim+tmux per <https://github.com/neovim/neovim/wiki/Following-HEAD#20170402>
if (has("nvim") && !empty($TMUX))
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
endif
" let g:ycm_semantic_triggers =  {
  " \   'c' : ['->', '.', ' ', '(', '[', '&'],
  " \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  " \             're!\[.*\]\s'],
  " \   'ocaml' : ['.', '#'],
  " \   'cpp,objcpp' : ['->', '.', '::'],
  " \   'perl' : ['->'],
  " \   'php' : ['->', '::'],
  " " \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  " \   'ruby' : ['.', '::'],
  " \   'lua' : ['.', ':'],
  " \   'erlang' : [':'],
  " \ }
