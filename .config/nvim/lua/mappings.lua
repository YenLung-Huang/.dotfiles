vim.cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function xmap(shortcut, command)
  map('x', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- quick save file, exit file
nmap('<leader>w', ':w<cr>')

-- sane regexes
nmap('/', '/\\v')
vmap('/', '/\\v')

nmap('<c-l>', ':nohlsearch<cr>')

-- don't jump when using *
nmap('*', 'yiw<Esc>: let @/ = @""<cr> :set hls<cr>')

-- keep search matches in the middle of the window
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Same when jumping around
nmap('g;', 'g;zz')
--nmap('g', 'g,zz') -- for some reason doesn't work well

-- Open a Quickfix window for the last search.
nmap("<leader>?", ":execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>")

-- more natural movement with wrap on
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Easy buffer navigation
-- nmap('<C-h>', '<C-w>h')
-- nmap('<C-j>', '<C-w>j')
-- nmap('<C-k>', '<C-w>k')
-- nmap('<C-l>', '<C-w>l')

-- Reselect visual block after indent/outdent
vmap('<', '<gv')
vmap('>', '>gv')

-- home and end line in command mode
cmap('<C-a>', '<Home>')
cmap('<C-e>', '<End>')
cmap('<C-b>', '<Left>') -- Move one character backward; the opposite of <C-f>
cmap('<C-f>', '<Right>')
cmap('<C-d>', '<Delete>')
imap('<C-a>', '<Home>')
imap('<C-e>', '<End>')
imap('<C-b>', '<Left>') -- Move one character backward; the opposite of <C-f>
imap('<C-f>', '<Right>')
imap('<C-d>', '<Delete>')

-- map c-c to esc
-- imap('<C-c>', '<Esc>')

-- Terminal
-- ESC to go to normal mode in terminal
tmap('<C-s>', '<C-\\><C-n>')
tmap('<Esc><Esc>', '<C-\\><C-n>')

-- window split;
vim.o.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.o.splitright = true -- when splitting vertically, move coursor to right pane

-- PLUGINS

-- Find files using Telescope command-line sugar.
nmap("<leader>p", "<cmd>Telescope find_files<cr>")
nmap("<leader>R", "<cmd>Telescope live_grep<cr>")
nmap("<leader>bb", "<cmd>Telescope buffers<cr>")
nmap("<leader>hh", "<cmd>Telescope help_tags<cr>")

-- LSP
vim.api.omnifunc = 'v:lua.vim.lsp.omnifunc'

nmap('K', '<cmd>Lspsaga hover_doc<cr>')
imap('<C-k>', '<cmd>Lspsaga hover_doc<cr>')
nmap('gh', '<cmd>Lspsaga lsp_finder<cr>')
nmap('<C-e>', '<cmd>Lspsaga show_line_diagnostics<CR>')
nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
nmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- nmap('<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
-- nmap('<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
-- nmap('<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
nmap('<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
nmap('<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
nmap('<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
nmap('<space>e', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>')
nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmap('<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>')
nmap('<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

-- Git
nmap('<leader>gb', ':Git blame<cr>')
nmap('<leader>gd', ':Gvdiffsplit<cr>')
nmap('<leader>gs', ':topleft Git<cr>')

-- netrw
nmap('<leader>eo', ':Explore<cr>'); -- explore file current directory
nmap('<leader>el', ':ex.<cr>'); -- explore project directory list

-- easy align
nmap('<leader>al', ':EasyAlign<cr>')
xmap('<leader>al', ':EasyAlign<cr>')
