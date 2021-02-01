" 自用的 vim 配置文件。:
" widows/linux 下的 Gvim8;
" macOS 下的 macvim 和 vim8
"
" Author:       Mark Huang <https://github.com/YenLung-Huang>
" Licence:      MIT
"==============================================================================

syntax on
set synmaxcol=200
set pyxversion=3
syntax sync minlines=256
" set pastetoggle=<F12>
set nocompatible
set path+=**
set clipboard=unnamed " 讓os跟vim的clipboard 共用
set number nu
set relativenumber
set cursorline
set cursorcolumn
set autoindent
set smartindent
set autoread
set wildmenu
set nottimeout " because use coc vim need this to escape fluently
set showcmd
set lazyredraw
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set hidden " if hidden is not set, TextEdit might fail.

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
set noswapfile

set cmdheight=2 " Better display for messages
set updatetime=100 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns

" folding
set foldmethod=syntax
set foldlevelstart=1
set foldnestmax=3

let php_folding = 1

map <silent> <C-C> <esc>
inoremap <silent> <C-C> <esc>

" make jump to current file work on neovim
map <silent> <C-6> :e# <CR>
map <silent> <C-^> :e# <CR>

" nohlsearch shortcut
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
let mapleader=" " " our <leader> will be the space key
let maplocalleader="-" " our <localleader> will be the '-' key
"
" Split windows fast
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>
nnoremap n nzz
nnoremap N Nzz

" quick save file, exit file
nnoremap <leader>w :w<CR>

" Move visual selection
nnoremap j gj
nnoremap k gk

set scrolloff=3
set sidescrolloff=5
" Use spaces instead to tabs
set expandtab
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
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'kshenoy/vim-signature'
" Plug 'mattn/emmet-vim'
Plug 'ryanoasis/vim-devicons'

" Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" js plugins
Plug 'posva/vim-vue'

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
else
  Plug 'Shougo/defx.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()

" Defx settings
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'defxplorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'indent:git:icons:filename:mark',
      \ })

" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 0

let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }

function! s:defx_my_settings() abort
        " Define mappings
        nnoremap <silent><buffer><expr> <CR>
                                \ defx#is_directory() ?
                                \ defx#do_action('open') :
                                \ defx#do_action('multi', ['drop', 'quit'])
        nnoremap <silent><buffer><expr> c
                                \ defx#do_action('copy')
        nnoremap <silent><buffer><expr> m
                                \ defx#do_action('move')
        nnoremap <silent><buffer><expr> p
                                \ defx#do_action('paste')
        nnoremap <silent><buffer><expr> P
                                \ defx#do_action('preview')
        nnoremap <silent><buffer><expr> l
		\ defx#is_directory() ?
                \ defx#do_action('open_tree', 'toggle') :
		\ defx#do_action('multi', ['drop', 'quit'])
        nnoremap <silent><buffer><expr> s
                                \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
        nnoremap <silent><buffer><expr> A
                                \ defx#do_action('new_directory')
        nnoremap <silent><buffer><expr> a
                                \ defx#do_action('new_file')
        nnoremap <silent><buffer><expr> d
                                \ defx#do_action('remove')
        nnoremap <silent><buffer><expr> r
                                \ defx#do_action('rename')
        nnoremap <silent><buffer><expr> .
                                \ defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> !
                                \ defx#do_action('execute_command')
        nnoremap <silent><buffer><expr> x
                                \ defx#do_action('execute_system')
        nnoremap <silent><buffer><expr> yy
                                \ defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> .
                                \ defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> ;
                                \ defx#do_action('repeat')
        nnoremap <silent><buffer><expr> h
                                \ defx#do_action('close_tree')
        nnoremap <silent><buffer><expr> ~
                                \ defx#do_action('cd')
	nnoremap <silent><buffer><expr> <BS>
	                        \ defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> q
                                \ defx#do_action('quit')
        nnoremap <silent><buffer><expr> <Space>
                                \ defx#do_action('toggle_select') . 'j'
        nnoremap <silent><buffer><expr> *
                                \ defx#do_action('toggle_select_all')
        nnoremap <silent><buffer><expr> j
                                \ line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k
                                \ line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer><expr> <C-r>
                                \ defx#do_action('redraw')
        nnoremap <silent><buffer><expr> cd
                                \ defx#do_action('change_vim_cwd')
        nnoremap <silent><buffer><expr> P defx#do_action('search',
                                \ fnamemodify(defx#get_candidate().action__path, ':h'))
endfunction

" Reveal file in defx
nnoremap <silent> <F4>     :<C-u>Defx -resume -search=`expand('%:p')` `getcwd()`<CR>
autocmd FileType defx call s:defx_my_settings()
nmap <silent> <C-\> :Defx <CR>

"==============================================================================
"=============================== Plugin Setting
"==============================================================================

nmap <silent> ]c :cn<CR>
nmap <silent> [c :cp<CR>

" Git gutter
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --hidden --glob '!.git' --smart-case --no-heading --color=always ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <silent> <Leader>R :Rg<CR>

" Automatically removing all trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Vim-easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif

let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

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


" Coc vim settings

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Emacs and bash style insert mode CTRL shortcuts
" <C-a> = Move to start of the line; like in vim command mode: c_ctrl-b; To insert previously inserted text, use <C-r>. or <Alt-.> (below)
inoremap <C-a> <Home>
cnoremap <C-a> <Home>
" <C-b> = Move one character backward; the opposite of <C-f>
inoremap <C-b> <Left>
cnoremap <C-b> <Left>
" <C-d> = Delete one character forward; the opposite of <C-h>
inoremap <silent><expr> <C-d> "\<C-g>u<Delete>"
cnoremap <C-d> <Delete>
" <C-e> = Move to end of the line (already exists in command mode: c_ctrl-e), this also cancels completion
inoremap <C-e> <End>
" <C-f> = Move one character forward; the opposite of <C-b>; <C-f> is too useful (for : / ?) to remap
inoremap <C-f> <Right>

" Vim-fugitive
nnoremap <leader>gb :Gblame<CR>

" ultisnips
" let g:UltiSnipsExpandTrigger = '<TAB>'
" let g:UltiSnipsListSnippets = '<Leader><TAB>'
" let g:UltiSnipsJumpForwardTrigger = '<C-J>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-K>'
" coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
color nord

autocmd FileType defx setlocal nonumber
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()
