-- Launch panel if nothing is typed after <leader>z
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

-- Most used functions
vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

-- Call insert link automatically when we start typing a link
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

return {
	"nvim-telekasten/telekasten.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-telekasten/calendar-vim"
	},
	ft = { 'markdown', 'telekasten' },
	keys = {
		{ "<leader>zt", "<cmd>Telekasten show_tags<CR>",   desc = "Search Telekasten Tags" },
		{ "<leader>zf", "<cmd>Telekasten follow_link<CR>", desc = "Follow Link/Tag under cursor" },
	},
	opts = {
		--config = function()
		--		require("telekasten").setup({
		home = vim.fn.expand("~/zettelkasten"),
		dailies = vim.fn.expand("~/zettelkasten/daily"),
		extension = ".md",
		new_note_filename = "title",
		tag_notation = "#tag", -- how tags look in files
		template_new_note = vim.fn.expand("~/zettelkasten/system/template.md"),
		template_new_daily = vim.fn.expand("~/zettelkasten/system/daily.md"),
		--		})
		--end,
	},
	--}
}
