return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }

      vim.keymap.set('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
      vim.keymap.set('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>')
      vim.keymap.set('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
      vim.keymap.set('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>')
      vim.keymap.set('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
      vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
      vim.keymap.set('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
      vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    end,
  }
}
