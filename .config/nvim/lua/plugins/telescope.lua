return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

			"nvim-telescope/telescope-smart-history.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					wrap_results = true,

					fzf = {},

					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "smart_history")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<space>fd", builtin.find_files)
			vim.keymap.set("n", "<space>ft", builtin.git_files)
			vim.keymap.set("n", "<space>fh", builtin.help_tags)
			vim.keymap.set("n", "<space>fg", builtin.live_grep)
			vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

			vim.keymap.set("n", "<space>gw", builtin.grep_string)
		end,
	},
}
