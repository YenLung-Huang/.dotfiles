return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			html = { "prettier", stop_after_first = true },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
			php = { "php_cs_fixer" },
			blade = { "blade-formatter" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 2500, lsp_fallback = true }
		end,
		formatters = {
			prettier = {
				-- 動態決定是否加上預設參數
				prepend_args = function(ctx)
					local util = require("conform.util")
					local config_files = {
						".prettierrc",
						".prettierrc.json",
						".prettierrc.js",
						"prettier.config.js",
						".prettierrc.yaml",
						".prettierrc.yml",
					}

					local found = util.find_file(config_files, { upward = true, path = ctx.dirname })
					if found then
						-- 找到設定檔 → 不加參數
						return {}
					else
						-- 沒找到設定檔 → 使用預設
						return { "--tab-width", "2" }
					end
				end,
			},
			php_cs_fixer = {
				env = { PHP_CS_FIXER_IGNORE_ENV = "1" },
			},
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, { desc = "Disable autoformat-on-save", bang = true })

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, { desc = "Re-enable autoformat-on-save" })
	end,
}
