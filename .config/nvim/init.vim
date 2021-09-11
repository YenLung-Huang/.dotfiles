" 自用的 vim 配置文件。:
" widows/linux 下的 Gvim8;
" macOS 下的 macvim 和 vim8
"
" Author:       Mark Huang <https://github.com/YenLung-Huang>
" Licence:      MIT
"==============================================================================

syntax on
set pyxversion=3
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

map <silent> <C-C> <esc>
inoremap <silent> <C-C> <esc>
" nohlsearch shortcut
nnoremap <silent> <C-l> :nohlsearch<CR>
let mapleader=" " " our <leader> will be the space key
let maplocalleader="-" " our <localleader> will be the '-' key
" Split windows fast
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

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
set bg=dark
set completeopt-=preview

"==============================================================================
"========================== Third plugins
"==============================================================================

call plug#begin('~/.vim/plugged')
" Enhanced plugins
" Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'akinsho/bufferline.nvim'
Plug 'hoob3rt/lualine.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'lewis6991/gitsigns.nvim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-test/vim-test'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-vinegar'
Plug 'kshenoy/vim-signature'
Plug 'blueyed/smarty.vim'
" Plug 'arcticicestudio/nord-vim'
Plug 'shaunsingh/nord.nvim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'

" Use release branch (Recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

" js plugins
" Plug 'posva/vim-vue'

" Initialize plugin system
call plug#end()

lua << EOF
require('lspconfig').intelephense.setup{}
require("bufferline").setup{}
require('lualine').setup {
  options = {
    theme = 'nord'
  }
}

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true
require('nord').set()

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

require'lspinstall'.setup()

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "intelephense", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

EOF


"==============================================================================
"=============================== Plugin Setting
"==============================================================================

" Netr
let g:netrw_fastbrowse = 0 " close buffer when open file
autocmd FileType netrw setl bufhidden=delete
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_sizestyle = 'h'
hi! link netrwMarkFile Search
" nnoremap <leader>eo :Explore<CR> " Explore file current directory
" nnoremap <leader>el :ex.<CR> " Explore project directory list

" Vim-commentary
autocmd FileType php setlocal commentstring=//\ %s

" Vim-Test
let g:test#php#phpunit#executable = 'docker exec suitecrm_suitecrm_1 ./vendor/bin/phpunit --configuration ./tests/phpunit.xml.dist --stop-on-failure'
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
" nmap <silent> t<C-n> :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR> 
" back to normal mode from terminal mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" signify settings
" g is means git
nnoremap <leader>gd :Gvdiffsplit<cr>

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

autocmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
        let h = sy#util#get_hunk_stats()
        if !empty(h)
                echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
        endif
endfunction

" fzf
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

" Pass an empty option dictionary if the screen is narrow
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, &columns > 120 ? fzf#vim#with_preview() : {}, <bang>0)

command! -bang -nargs=? -complete=dir Buffers
  \ call fzf#vim#buffers(<q-args>, &columns > 120 ? fzf#vim#with_preview() : {}, <bang>0)

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
nnoremap <leader>gl :Gclog -10 -- %<CR>

" Defx
nnoremap <leader>eo :Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR> " Explore file current directory
nnoremap <leader>el :Defx -new<CR> " Explore project directory list
" This make defx works like vinegar plugins
nnoremap - :Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')` -new<CR> " Explore file current directory

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
        " Define mappings
        nnoremap <silent><buffer><expr> <CR>
                                \ defx#do_action('open')
        nnoremap <silent><buffer><expr> c
                                \ defx#do_action('copy')
        nnoremap <silent><buffer><expr> m
                                \ defx#do_action('move')
        nnoremap <silent><buffer><expr> p
                                \ defx#do_action('paste')
        nnoremap <silent><buffer><expr> h
                                \ defx#do_action('close_tree')
        nnoremap <silent><buffer><expr> l
                                \ defx#do_action('open_tree')
        nnoremap <silent><buffer><expr> E
                                \ defx#do_action('open', 'vsplit')
        nnoremap <silent><buffer><expr> P
                                \ defx#do_action('preview')
        nnoremap <silent><buffer><expr> o
                                \ defx#do_action('open_tree', 'toggle')
        nnoremap <silent><buffer><expr> K
                                \ defx#do_action('new_directory')
        nnoremap <silent><buffer><expr> %
                                \ defx#do_action('new_file')
        nnoremap <silent><buffer><expr> C
                                \ defx#do_action('toggle_columns',
                                \                'mark:indent:icon:filename:type:size:time')
        nnoremap <silent><buffer><expr> S
                                \ defx#do_action('toggle_sort', 'time')
        nnoremap <silent><buffer><expr> D
                                \ defx#do_action('remove')
        nnoremap <silent><buffer><expr> r
                                \ defx#do_action('rename')
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
        nnoremap <silent><buffer><expr> -
                                \ defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> ~
                                \ defx#do_action('cd')
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
        nnoremap <silent><buffer><expr> <C-l>
                                \ defx#do_action('redraw')
        nnoremap <silent><buffer><expr> <C-g>
                                \ defx#do_action('print')
        nnoremap <silent><buffer><expr> cd
                                \ defx#do_action('change_vim_cwd')
endfunction

" ultisnips
" let g:UltiSnipsExpandTrigger = '<TAB>'
" let g:UltiSnipsListSnippets = '<Leader><TAB>'
" let g:UltiSnipsJumpForwardTrigger = '<C-J>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-K>'

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    set termguicolors
  endif
endif

" this sometimes will freeze the file

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=1
set foldnestmax=2


" add this to avoid delay from sql, text file
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

colorscheme nord
