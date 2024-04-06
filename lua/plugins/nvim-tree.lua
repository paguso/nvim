return {
	"nvim-tree/nvim-tree.lua",

	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		-- empty setup using defaults
		require("nvim-tree").setup()

		-- OR setup with some options
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})

		-- key mappings
		vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", { desc = "File [E]xplorer [E]xhibition Toggle" })
		vim.keymap.set(
			"n",
			"<leader>ef",
			":NvimTreeFindFileToggle<CR>",
			{ desc = "File [E]xplorer: show current [F]ile" }
		)
	end,
}
