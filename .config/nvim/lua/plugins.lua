return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- common
  use 'tpope/vim-fugitive' -- Git commands
  use 'kshenoy/vim-signature' -- Hilight bookmark
  use 'rhysd/vim-grammarous' -- grammar check
  -- use 'andymass/vim-matchup' -- matching parens and more
  use 'bronson/vim-trailing-whitespace' -- highlight trailing spaces
  use 'rhysd/git-messenger.vim'
  use 'akinsho/bufferline.nvim'
  use 'hoob3rt/lualine.nvim'
  use 'junegunn/vim-easy-align'
  use 'sainnhe/sonokai'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({
        signs = {
          add = {hl = 'GitSignsAdd'   , text = '▏', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change = {hl = 'GitSignsChange', text = '▏', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        current_line_blame = false
      })
    end
  }

  require('gitsigns').setup()

  require('bufferline').setup {}

  require('lualine').setup {
    options = {
      theme = 'sonokai',
      component_separators = { left = '╲', right = '╲'},
      section_separators = { left = '', right = ''},
    }
  }

  -- general dev
  use 'editorconfig/editorconfig-vim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind-nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = {},
    },
    -- indent = {
      --   enable = true,
      --   disable = {},
      -- },
      ensure_installed = {
        "html", "css", "vim", "lua", "php",
        "javascript", "typescript", "tsx", "markdown"
      },
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false
    }
    )

    -- search
    use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
    use 'tpope/vim-eunuch' -- wrappers UNIX commands
    use 'tpope/vim-surround' -- surround characters shortcuts
    use 'tpope/vim-vinegar' -- file browser
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'
    use 'kyazdani42/nvim-web-devicons' -- icons when searching

    -- testing
    use 'kassio/neoterm' -- terminal wrapper
    use 'janko-m/vim-test' -- testing commands

    -- javascript
    use { 'HerringtonDarkholme/yats.vim', ft = 'typescript' }
    use 'othree/javascript-libraries-syntax.vim'

    -- css
    use { 'ap/vim-css-color', ft = 'css, sass, scss' } -- Color hex code

    -- php smarty
    use { 'blueyed/smarty.vim', ft = 'tpl' }
  end)
