-- [[ Setting options ]]
-- See `:help vim.o`

HOME = os.getenv("HOME")

local opt = vim.opt

-- You have to turn this one on :)
opt.inccommand = "split"

-- Set highlight on search
-- opt.hlsearch = false
opt.grepprg = "rg --vimgrep --no-heading --smart-case"

opt.ignorecase = true -- ignore letter case when searching
opt.smartcase = true -- case insentive unless capitals used in search

-- Enable break indent
opt.breakindent = true

-- basic settings
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.backspace = "indent,eol,start" -- backspace works on every char in insert mode

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- Save undo history
opt.undofile = true

opt.history = 1000
opt.dictionary = "/usr/share/dict/words"
opt.startofline = true

-- Display
opt.showmatch = true -- show matching brackets
opt.scrolloff = 2 -- always show 2 rows from edge of the screen
opt.sidescrolloff = 9
opt.synmaxcol = 300 -- stop syntax highlight after x lines for performance
opt.laststatus = 2 -- always and ONLY the last window
-- opt.winbar = '%f'

opt.list = false -- do not display white characters
vim.wo.foldenable = false -- can be enabled directly in opened file - using 'zi' - toogle fold
opt.foldlevelstart = 1
vim.wo.foldlevel = 4 -- limit folding to 4 levels
vim.wo.foldminlines = 1
vim.wo.foldnestmax = 2
vim.wo.foldmethod = "expr" -- use language syntax to generate folds
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

opt.wrap = true --do not wrap lines even if very long
opt.eol = true -- show if there's no eol char
opt.linebreak = true
opt.showbreak = "↪" -- character to show when line is broken

opt.number = true -- line number on the left
opt.relativenumber = true
-- opt.numberwidth = 3 -- always reserve 3 spaces for line number

opt.splitbelow = true
opt.splitright = true

-- Decrease update time
opt.updatetime = 250
opt.signcolumn = "yes" -- keep 1 column for coc.vim  check
-- opt.shada = { "'10", "<0", "s10", "h" }

opt.modelines = 0
opt.showcmd = true -- display command in bottom bar

-- Case insensitive searching UNLESS /C or capital in search
opt.matchtime = 2 -- delay before showing matching paren
-- opt.mps = opt.mps .. ",<:>"

-- With oil we may want to close the netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- White characters
-- opt.indentexpr = true
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2 -- 1 tab = 2 spaces
opt.shiftwidth = 2 -- indentation rule
opt.formatoptions = "qnj1" -- q  - comment formatting; n - numbered lists; j - remove comment when joining lines; 1 - don't break after one-letter word
opt.expandtab = true -- expand tab to spaces

-- Backup files
opt.backup = false -- use backup files
opt.writebackup = false
opt.swapfile = false -- do not use swap file
opt.undodir = HOME .. "/.config/nvim/tmp/undo//" -- undo files
opt.backupdir = HOME .. "/.config/nvim/tmp/backup//" -- backups
-- opt.directory = "/.config/nvim/tmp/swap//" -- swap files

-- Commands mode
opt.wildmenu = true -- on TAB, complete options for system command
opt.wildignore =
	"deps,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc"

-- Only show cursorline in the current window and in normal mode.
-- opt.cursorcolumn = true
-- opt.cursorline = true
-- vim.cmd([[
--   augroup cline
--       au!
--       au WinLeave * set nocursorline nocursorcolumn
-- 		  au WinEnter * set cursorline cursorcolumn
--       au InsertEnter * set nocursorline nocursorcolumn
-- 		  au InsertLeave * set cursorline cursorcolumn
--   augroup END
-- u]])
--
