"==============================================================================
" 自用的 vim 配置文件。:
" widows/linux 下的 Gvim8;
" macOS 下的 macvim 和 vim8
"
" Author:       Mark Huang <https://github.com/YenLung-Huang>
" Licence:      MIT
"==============================================================================

syntax on
set synmaxcol=128
syntax sync minlines=256
" set pastetoggle=<F12>
set nocompatible
set path+=**
" 讓os跟vim的clipboard 共用
set clipboard=unnamed
set number nu
set relativenumber
set cursorline
set autoindent
set smartindent
set autoread
set wildmenu
set showcmd
set lazyredraw

" folding
set foldmethod=syntax
set foldenable " 預設全部關閉
set foldnestmax=3
" set foldcolumn=1
set foldlevel=1

" php
let php_folding = 1 " php 預設
" fix switch statements error"
let g:PHP_vintage_case_default_indent = 1

map <silent> <C-C> <Esc>
inoremap <silent> <C-C> <Esc>
" nohlsearch shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
" our <leader> will be the space key
let mapleader=" "
" our <localleader> will be the '-' key
let maplocalleader="-"
"
" Split windows fast
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>

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
" Set wrap
set wrap
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
set tags=tags,tags.vendor
if has("gui_running")
        set renderoptions=type:directx
        set guifont=Fira\ Code\ Retina:h14
        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar
        set guioptions-=r  "remove right-hand scroll bar
        set guioptions-=L  "remove left-hand scroll bar
endif

"==============================================================================
"========================== Third plugins
"==============================================================================

call plug#begin('~/.vim/plugged')
" Enhanced plugins
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'arcticicestudio/nord-vim'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'kshenoy/vim-signature'
Plug 'mattn/emmet-vim'
Plug 'Konfekt/FastFold'
Plug 'ryanoasis/vim-devicons'

Plug 'dense-analysis/ale'

" js plugins
Plug 'posva/vim-vue'

" Php plugins
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'shawncplus/phpcomplete.vim'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'jwalton512/vim-blade'
Plug 'nelsyeung/twig.vim'
Plug '2072/PHP-Indenting-for-VIm'
" Initialize plugin system
call plug#end()


"==============================================================================
"=============================== Plugin Setting
"==============================================================================

" Windows Gvim need to reload menu with UTF-8 encoding
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim

" NERDTree Settings
map <silent> <C-\> :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

" Airline Settings
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep ='|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='nord'

" Ale
let b:ale_linters = ['phpcs', 'php']
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'php': ['php_cs_fixer'],
\}
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_use_global = 1
let g:ale_fix_on_save = 1

" nerdCommenter Settings"
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = { 'php': { 'left': '//'}, 'html': { 'left': '<!--', 'right': '-->'}}

" fzf
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
" the silverseacher
" command! -bang -nargs=* Ag
  " \ call fzf#vim#ag(<q-args>,
  " \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  " \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  " \                 <bang>0)
" nnoremap <silent> <Leader>A :Ag<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <silent> <Leader>R :Rg<CR>

" Automatically removing all trailing whitespace
" autocmd BufWritePre * %s/\s\+$//e

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

" vim-php-namespace
let g:php_namespace_sort_after_insert = 1
" autocmd FileType php inoremap <Leader>s <Esc>:call PhpSortUse()<CR>
autocmd FileType php noremap <Leader>s :call PhpSortUse()<CR>

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
" autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
" autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

" ctags
function! UpdateTags()
  let tags = 'tags'

  if filereadable(tags)
    let file = substitute(expand('%:p'), getcwd() . '/', '', '')

    " remove tags of file
    call system('sed -ri "/\s+' . escape(file, './') . '/d"' . tags)

    " append tags of file
    call system('ctags -a "' . file . '"')
  endif
endfunction

" Fixed vim pasting
" Because Vim doesn't like
" pasting that works.
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
" end fixed

autocmd BufWritePost *.php call UpdateTags()
command! Ctags call system('ctags --recurse --exclude=vendor --exclude=node_modules --exclude=public --exclude="*.json" --exclude="*.min.*" && ctags --recurse -f tags.vendor vendor node_modules &')

" ultisnips
let g:UltiSnipsExpandTrigger = '<TAB>'
" let g:UltiSnipsListSnippets = '<Leader><TAB>'
let g:UltiSnipsJumpForwardTrigger = '<C-J>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

color nord
set background=dark
