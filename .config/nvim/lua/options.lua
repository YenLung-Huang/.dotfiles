-- [[ Setting options ]]
-- See `:help vim.o`

HOME = os.getenv("HOME")

local opt = vim.opt

-- You have to turn this one on :)
opt.inccommand = "split"

-- Set highlight on search
-- opt.hlsearch = false
opt.grepprg = "rg --vimgrep --no-heading --smart-case"
opt.grepformat = "%f:%l:%c:%m,%f"

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

-- ==========================================================
-- 智慧型 CursorLine 設定 (結合專注模式 + 輸入變色)
-- ==========================================================

-- 1. 建立一個群組來管理所有相關的自動命令
local cursor_grp = vim.api.nvim_create_augroup("SmartCursorLine", { clear = true })

-- 2. 基礎設定：全域開啟 cursorline
vim.opt.cursorline = true

-- 3. [專注模式] 邏輯：只有「當前視窗」才顯示 cursorline
-- 當進入視窗 (WinEnter) 或 buffer (BufEnter) 時，開啟
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = cursor_grp,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- 當離開視窗 (WinLeave) 時，關閉 (讓畫面保持乾淨)
vim.api.nvim_create_autocmd("WinLeave", {
	group = cursor_grp,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- 4. [輸入變色] 邏輯：打字時變深藍色，離開時恢復
-- 進入插入模式：變更顏色為深藍
vim.api.nvim_create_autocmd("InsertEnter", {
	group = cursor_grp,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true -- 確保是開啟的
		-- 設定高亮：深藍色背景，粗體
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000055", bold = true })
	end,
})

-- 離開插入模式：清除自訂顏色 (恢復成你原本主題的樣子)
vim.api.nvim_create_autocmd("InsertLeave", {
	group = cursor_grp,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true
		-- 清除 CursorLine 的屬性，讓它自動繼承原本 ColorScheme 的設定
		vim.api.nvim_set_hl(0, "CursorLine", {})
	end,
})
