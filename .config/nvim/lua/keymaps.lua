-- [[ Basic Keymaps ]]
local set = vim.keymap.set
local k = vim.keycode

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- [[ General ]]

-- Set space to Nop
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- quick save file
set("n", "<leader>w", ":w<cr>")

-- Execute current line/file
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- [[ Movement ]]

-- Basic movement keybinds, these make navigating splits easy for me
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move lines up/down
set("n", "<M-j>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! ]c]])
	else
		vim.cmd([[m .+1<CR>==]])
	end
end)
set("n", "<M-k>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! [c]])
	else
		vim.cmd([[m .-2<CR>==]])
	end
end)

-- Tab navigation
set("n", "<left>", "gT")
set("n", "<right>", "gt")

-- [[ Editing ]]

-- Reselect visual block after indent/outdent
set("v", "<", "<gv")
set("v", ">", ">gv")

-- home and end line in command mode
set("c", "<C-a>", "<Home>")
set("c", "<C-e>", "<End>")
set("c", "<C-b>", "<Left>")
set("c", "<C-f>", "<Right>")
set("c", "<C-d>", "<Delete>")

-- home and end line in insert mode
set("i", "<C-a>", "<Home>")
set("i", "<C-e>", "<End>")
set("i", "<C-b>", "<Left>")
set("i", "<C-f>", "<Right>")
set("i", "<C-d>", "<Delete>")

-- [[ Search ]]

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd.nohl()
		return ""
	else
		return k("<CR>")
	end
end, { expr = true })

-- clear matches
set("n", "<C-b>", ":noh<cr>:call clearmatches()<cr>", { silent = true })

-- don't jump when using *
set("n", "*", 'yiw<Esc>: let @/ = @""<cr> :set hls<cr>', { silent = true })

-- keep search matches in the middle of the window
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Same when jumping around
set("n", "g;", "g;zz")

-- Open a Quickfix window for the last search.
set("n", "<leader>?", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>", { silent = true })

-- [[ UI ]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

-- [[ Terminal ]]
set("t", "<C-s>", '<C-"><C-n>', { silent = true })
set("t", "<Esc><Esc>", '<C-"><C-n>', { silent = true })

-- [[ Plugins ]]

-- Telescope
set("n", "<leader>p", "<cmd>Telescope find_files<cr>", { silent = true })
set("n", "<leader>R", "<cmd>Telescope live_grep<cr>", { silent = true })
set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { silent = true })
set("n", "<leader>hh", "<cmd>Telescope help_tags<cr>", { silent = true })

-- LSP
set("n", "K", "<cmd>Lspsaga hover_doc<cr>", { silent = true })
set("n", "gh", "<cmd>Lspsaga lsp_finder<cr>", { silent = true })
set("n", "<C-e>", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true })
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })
set("n", "<leader>e", "<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>", { silent = true })
set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })
set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })
set("n", "<leader>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", { silent = true })
set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = true })
set("n", "<space>tt", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end)

-- Git
set("n", "<leader>gb", ":Git blame<cr>", { silent = true })
set("n", "<leader>gd", ":Gvdiffsplit<cr>", { silent = true })
set("n", "<leader>gs", ":topleft Git<cr>", { silent = true })

-- oil (instead of netrw)
set("n", "<leader>el", ":edit.<cr>", { silent = true }) -- explore project directory list

-- easy align
set("n", "<leader>al", ":EasyAlign<cr>", { silent = true })
set("x", "<leader>al", ":EasyAlign<cr>", { silent = true })

