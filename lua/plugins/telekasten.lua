return {
	"nvim-telekasten/telekasten.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-telekasten/calendar-vim"
	},
	cmd = { "Telekasten" }, -- load on first Telekasten command
	keys = {
		{ "<leader>z",  "<cmd>Telekasten panel<CR>",           desc = "Telekasten Panel" },
		{ "<leader>zf", "<cmd>Telekasten find_notes<CR>",      desc = "Find Notes" },
		{ "<leader>zg", "<cmd>Telekasten search_notes<CR>",    desc = "Search Notes" },
		{ "<leader>zd", "<cmd>Telekasten goto_today<CR>",      desc = "Go to Today" },
		{ "<leader>zz", "<cmd>Telekasten follow_link<CR>",     desc = "Follow Link" },
		{ "<leader>zn", "<cmd>Telekasten new_note<CR>",        desc = "New Note" },
		{ "<leader>zc", "<cmd>Telekasten show_calendar<CR>",   desc = "Show Calendar" },
		{ "<leader>zb", "<cmd>Telekasten show_backlinks<CR>",  desc = "Show Backlinks" },
		{ "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", desc = "Insert Image Link" },
		{ "<leader>zt", "<cmd>Telekasten show_tags<CR>",       desc = "Search Tags" },
	},
	opts = {
		home               = vim.fn.expand("~/zettelkasten"),
		dailies            = vim.fn.expand("~/zettelkasten/daily"),
		extension          = ".md",
		new_note_filename  = "title",
		tag_notation       = "#tag",
		template_new_note  = vim.fn.expand("~/zettelkasten/system/template.md"),
		template_new_daily = vim.fn.expand("~/zettelkasten/system/daily.md"),
	},
}
