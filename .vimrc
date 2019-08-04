" Pluging Start
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'arcticicestudio/nord-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
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

syntax on
set nocompatible
set path+=**
set clipboard=unnamed
set number nu
set relativenumber
set cursorline
set autoindent
set smartindent
set autoread
set wildmenu
set showcmd

" buffer short cut
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
map <silent> <C-C> <Esc>
" nohlsearch shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" our <leader> will be the space key
let mapleader=" "
" our <localleader> will be the '-' key
let maplocalleader="-"

" Some basic PSR code style rules
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


" NERDTree Settings
map <silent> <C-\> :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

let g:airline#extensions#ale#enabled = 1
" Airline Settings
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep ='|'
let g:airline_theme='nord'
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

colorscheme nord
" Automatically removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Vim-easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)

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

if has("gui_running")
        set renderoptions=type:directx
        set guifont=Fira\ Code:h14
        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=L  "remove left-hand scroll bar
endif

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"...

"Force cursor styling in nvim+tmux per <https://github.com/neovim/neovim/wiki/Following-HEAD#20170402>
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
" ultisnips
let g:UltiSnipsExpandTrigger = '<TAB>'
" let g:UltiSnipsListSnippets = '<Leader><TAB>'
let g:UltiSnipsJumpForwardTrigger = '<C-J>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

