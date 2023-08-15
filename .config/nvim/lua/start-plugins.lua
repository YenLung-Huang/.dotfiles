-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use { 'wbthomason/packer.nvim' }

  -- use { 'christoomey/vim-tmux-navigator' }

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompetion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'onsails/lspkind-nvim' },
  }
  use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }

  -- Git related plugins
  use 'tpope/vim-fugitive' -- Git commands
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  -- Syntax enhanceer
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Vim layout related plugins
  use 'sainnhe/sonokai' -- Theme inspired by sublime text monokai
  use 'akinsho/bufferline.nvim'
  use 'hoob3rt/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Else plugins
  use 'junegunn/vim-easy-align'
  use 'kshenoy/vim-signature' -- Hilight bookmark
  use 'rhysd/vim-grammarous' -- grammar check
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'ntpeters/vim-better-whitespace' -- highlight trailing spaces
  use 'tpope/vim-eunuch' -- wrappers UNIX commands
  use 'tpope/vim-surround' -- surround characters shortcuts
  use { 'stevearc/oil.nvim', config = function() require('oil').setup() end } -- file browser

  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'kyazdani42/nvim-web-devicons' -- icons when searching

  -- general dev
  use 'echuraev/translate-shell.vim' -- translate text with call google rpc

  use 'editorconfig/editorconfig-vim'


  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  })

  -- testing
  use 'kassio/neoterm' -- terminal wrapper
  use 'janko-m/vim-test' -- testing commands

  -- css
  use 'ap/vim-css-color' -- Color hex code

  -- php smarty
  use { 'blueyed/smarty.vim', ft = 'tpl' }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end

end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
