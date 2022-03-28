HOME = os.getenv("HOME")

-- not find
-- syntax on
-- set termguicolors
-- set path+=**
-- set clipboard=unnamed -- 讓os跟vim的clipboard 共用

vim.g.mapleader = ' '
vim.g.maplocalleader = '-'

-- basic settings
vim.o.termguicolors = true
vim.o.clipboard = 'unnamed'
vim.o.encoding = "utf-8"
vim.o.fileencoding = 'utf-8'
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode
vim.o.completeopt = 'menuone,noselect'
vim.o.history = 1000
vim.o.dictionary = '/usr/share/dict/words'
vim.o.startofline = true

-- Mapping waiting time
vim.o.timeout = false
vim.o.ttimeout = true
vim.o.ttimeoutlen = 100

-- Display
vim.o.showmatch  = true -- show matching brackets
vim.o.scrolloff = 3 -- always show 3 rows from edge of the screen
vim.o.sidescrolloff = 9
vim.o.synmaxcol = 300 -- stop syntax highlight after x lines for performance
vim.o.laststatus = 2 -- always show status line

vim.o.list = false -- do not display white characters
vim.wo.foldenable = true -- can be enabled directly in opened file - using 'zi' - toogle fold
vim.o.foldlevelstart=1
vim.o.foldlevel = 1 -- limit folding to 4 levels
vim.o.foldminlines = 1
vim.o.foldnestmax = 2
vim.wo.foldmethod = 'expr' -- use language syntax to generate folds
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.wrap = false --do not wrap lines even if very long
vim.o.eol = false -- show if there's no eol char
vim.o.showbreak= '↪' -- character to show when line is broken

vim.o.number = true -- line number on the left
vim.o.relativenumber = true
vim.o.numberwidth = 3 -- always reserve 3 spaces for line number
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check
vim.o.modelines = 0
vim.o.showcmd = true -- display command in bottom bar

-- Search
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed
vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search

vim.o.matchtime = 2 -- delay before showing matching paren
vim.o.mps = vim.o.mps .. ",<:>"

-- White characters
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2 -- 1 tab = 2 spaces
vim.o.shiftwidth = 2 -- indentation rule
vim.o.formatoptions = 'qnj1' -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
vim.o.expandtab = true -- expand tab to spaces

-- Backup files
vim.o.backup = true -- use backup files
vim.o.writebackup = false
vim.o.swapfile = false -- do not use swap file
vim.o.undodir = HOME .. '/.vim/tmp/undo//'     -- undo files
vim.o.backupdir = HOME .. '/.vim/tmp/backup//' -- backups
vim.o.directory = '/.vim/tmp/swap//'   -- swap files

vim.cmd([[
  au FileType python                  set ts=4 sw=4
  au BufRead,BufNewFile *.md          set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.ppmd        set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.markdown    set ft=mkd tw=80 syntax=markdown
  au BufRead,BufNewFile *.slimbars    set syntax=slim
]])

-- Commands mode
vim.o.wildmenu = true -- on TAB, complete options for system command
vim.o.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'

-- Only show cursorline in the current window and in normal mode.
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline
      au WinEnter * set cursorline
      au InsertEnter * set nocursorline
      au InsertLeave * set cursorline
  augroup END
]])

vim.o.background = 'dark'
vim.cmd('colorscheme sonokai')
vim.g.sonokai_style = 'maia'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_better_performance = 1

-- vim.g.python3_host_prog = "/Users/grzegorz/.asdf/shims/python3"
-- vim.g.python_host_prog = "/Users/grzegorz/.asdf/shims/python2"