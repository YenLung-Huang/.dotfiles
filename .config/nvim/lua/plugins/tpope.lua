return {
  {
    'tpope/vim-unimpaired',
  },
  {
    'tpope/vim-repeat',
  },
  {
    'tpope/vim-commentary',
  },
  {
    'tpope/vim-surround',
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>')
      vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<cr>')
      vim.keymap.set('n', '<leader>gs', ':topleft Git<cr>')
    end,
  },
}
