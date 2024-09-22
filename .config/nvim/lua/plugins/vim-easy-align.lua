return {
	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set("n", "<leader>al", "<cmd>EasyAlign<cr>")
			vim.keymap.set("x", "<leader>al", "<cmd>EasyAlign<cr>")
		end,
	},
}
