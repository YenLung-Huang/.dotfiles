return {
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,

		-- === 新增這段 opts 設定 ===
		opts = {
			-- 如果有 TMUX 環境變數才啟用 tmux 整合，否則設為 nil (關閉)
			multiplexer_integration = vim.env.TMUX and "tmux" or nil,
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
