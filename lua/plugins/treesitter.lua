return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "markdown", "latex" },
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
		vim.treesitter.language.register('markdown', 'telekasten')
	end,
}
