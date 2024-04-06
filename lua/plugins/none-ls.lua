return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				--[[ null_ls.builtins.formatting.astyle.with({
					args = { "--style=kr", "--indent=tab", "-n" },
				}), ]]
				null_ls.builtins.formatting.stylua,
				--null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.cppcheck,
				--null_ls.builtins.completion.spell,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
