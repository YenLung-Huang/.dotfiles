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
				defaults = {
					preview = {
						treesitter = false,
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>ff", builtin.git_files)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep)
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })

			vim.keymap.set("n", "<space>gw", builtin.grep_string)
		end,
	},
}
