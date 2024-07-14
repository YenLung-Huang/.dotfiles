return {
  {
    "sainnhe/sonokai",
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
    config = function ()
      require('lualine').setup {
        options = {
          theme = 'sonokai',
        },
        sections = {
          lualine_b = { 'branch', 'diff', 'diagnostics' },
        }
      }
    end,
  }
}
