-- [[ Setting options ]]
-- See `:help vim.o`

HOME = os.getenv("HOME")

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- basic settings
vim.o.clipboard = 'unnamed'
vim.o.encoding = "utf-8"
vim.o.fileencoding = 'utf-8'
vim.o.backspace = "indent,eol,start" -- backspace works on every char in insert mode

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Save undo history
vim.o.undofile = true

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
vim.o.laststatus = 2 -- always and ONLY the last window
-- vim.o.winbar = '%f'

vim.o.list = false -- do not display white characters
vim.wo.foldenable = false -- can be enabled directly in opened file - using 'zi' - toogle fold
vim.o.foldlevelstart = 1
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

-- Decrease update time
vim.o.updatetime = 250
vim.o.signcolumn = 'yes' -- keep 1 column for coc.vim  check

vim.o.modelines = 0
vim.o.showcmd = true -- display command in bottom bar

-- Search
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.incsearch = true -- starts searching as soon as typing, without enter needed

vim.o.ignorecase = true -- ignore letter case when searching
vim.o.smartcase = true -- case insentive unless capitals used in search

-- Case insensitive searching UNLESS /C or capital in search
vim.o.matchtime = 2 -- delay before showing matching paren
vim.o.mps = vim.o.mps .. ",<:>"

-- White characters
vim.o.indentexpr = false
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

-- Commands mode
vim.o.wildmenu = true -- on TAB, complete options for system command
vim.o.wildignore = 'deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc'

-- Only show cursorline in the current window and in normal mode.
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.cmd([[
  augroup cline
      au!
      au WinLeave * set nocursorline nocursorcolumn
		  au WinEnter * set cursorline cursorcolumn
      au InsertEnter * set nocursorline nocursorcolumn
		  au InsertLeave * set cursorline cursorcolumn
  augroup END
]])

-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_transparent_background = 1
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_better_performance = 1

vim.cmd [[colorscheme sonokai]]
