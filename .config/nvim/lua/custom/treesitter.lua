-- local treesitter = require "nvim-treesitter"

local M = {}

M.setup = function()
  local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

  require("nvim-treesitter").setup {
    ensure_install = { "core", "stable" },
  }

  local syntax_on = {
    elixir = true,
    php = true,
  }

end

M.setup()

return M
