" 自用的 vim 配置文件。:
" widows/linux 下的 Gvim8;
" macOS 下的 macvim 和 vim8
"
" Author:       Mark Huang <https://github.com/YenLung-Huang>
" Licence:      MIT
"==============================================================================

syntax on
set pyxversion=3
" syntax sync minlines=256
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
set regexpengine=1

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
set foldnestmax=10
set nofoldenable
set foldlevel=2
set foldopen-=block

map <silent> <C-C> <esc>
inoremap <silent> <C-C> <esc>

" nohlsearch shortcut
nnoremap <silent> <C-l> :nohlsearch<CR>
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
" set tags=tags,tags.vendor

"==============================================================================
"========================== Third plugins
"==============================================================================

call plug#begin('~/.vim/plugged')
" Enhanced plugins
Plug 'mhinz/vim-signify'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-test/vim-test'
" Plug 'tpope/vim-vinegar'
Plug 'arcticicestudio/nord-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'kshenoy/vim-signature'
Plug 'blueyed/smarty.vim'

Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" js plugins
" Plug 'posva/vim-vue'

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'kristijanhusak/defx-git'
else
  Plug 'Shougo/defx.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Initialize plugin system
call plug#end()


"==============================================================================
"=============================== Plugin Setting
"==============================================================================
"
" Vim-commentary
autocmd FileType php setlocal commentstring=//\ %s

" Defx settings
call defx#custom#option('_', {
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'defxplorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'indent:git:mark:filename:type:size:time',
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
        nnoremap <silent><buffer><expr> d
                                \ defx#do_action('new_directory')
        nnoremap <silent><buffer><expr> %
                                \ defx#do_action('new_file')
        nnoremap <silent><buffer><expr> D
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
        nnoremap <silent><buffer><expr> *
                                \ defx#do_action('toggle_select') . 'j'
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
nnoremap <leader>e :Defx<CR>
" Test
let g:test#php#phpunit#executable = 'docker exec suitecrm_suitecrm_1 ./vendor/bin/phpunit --configuration ./tests/phpunit.xml.dist --stop-on-failure'
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
" nmap <silent> t<C-n> :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR> 

if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" signify settings
" g is means git
nnoremap <leader>gd :Gdiffsplit!<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

autocmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
        let h = sy#util#get_hunk_stats()
        if !empty(h)
                echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
        endif
endfunction

" Airline Settings
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep ='|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='nord'

" nerdCommenter Settings"
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = { 'php': { 'left': '//'}, 'html': { 'left': '<!--', 'right': '-->'}}

" fzf
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

" Pass an empty option dictionary if the screen is narrow
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, &columns > 80 ? fzf#vim#with_preview() : {}, <bang>0)

" let g:fzf_preview_window = []

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --hidden --glob '!.git' --smart-case --no-heading --color=always ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <silent> <Leader>R :Rg<CR>

" Automatically removing all trailing whitespace
" autocmd BufWritePre * %s/\s\+$//e

" Vim-easy-align settings
" Start interactive EasyAlign in visual mode (e.g. vipga)
vmap <Leader>al <Plug>(EasyAlign)
nmap <Leader>al <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif

let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

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
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight symbol under cursor on CursorHold coc-highlight will slow down
" when open log
" autocmd CursorHold * silent call CocActionAsync('highlight')

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
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
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
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
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
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR>

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

" this sometimes will freeze the file
let g:coc_markdown_disabled_languages = ['php', 'log', 'javascript']

let g:indentLine_fileTypeExclude = ['defx']
let g:indent_blankline_char = '¦'

autocmd FileType defx setlocal nonumber
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()
