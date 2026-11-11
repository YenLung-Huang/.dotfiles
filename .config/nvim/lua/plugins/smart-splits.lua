return {
	{
		"smart-splits-nvim/smart-splits.nvim",
		lazy = false,
		dependencies = {
			"smart-splits-nvim/backend-tmux", -- add the backend for your multiplexer
		},

		-- === 新增這段 opts 設定 ===
		opts = {
			mux = {
				backend = "smart-splits-backend-tmux", -- moved from multiplexer_integration = 'tmux'
			},
		},
		-- ========================

		keys = {
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = { "n" },
				desc = "Move to left window",
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = { "n" },
				desc = "Move to down window",
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = { "n" },
				desc = "Move to up window",
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = { "n" },
				desc = "Move to right window",
			},
		},
	},
}
