return { -- Autoformat
	"stevearc/conform.nvim",
	branch = "nvim-0.9",
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "astyle" },
			h = { "astyle" },
			cpp = { "astyle" },
			-- Conform can also run multiple formatters sequentially
			python = { "isort", "black" },
			json = { "jq" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
		formatters = {
			-- Use the nearest .astylerc above the file (e.g. a project's code
			-- style). If there is none, pass --project=none: astyle otherwise
			-- picks up any .astylerc in its working directory (nvim's cwd),
			-- which may belong to an unrelated project.
			astyle = {
				prepend_args = function(_, ctx)
					local rc = vim.fs.find({ ".astylerc", "_astylerc" }, { upward = true, path = ctx.dirname })[1]
					return rc and { "--options=" .. rc } or { "--project=none" }
				end,
			},
		},
	},
}
