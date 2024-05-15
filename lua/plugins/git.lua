return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			local map = function(shortcut, action, hlp)
				vim.keymap.set("n", shortcut, action, { desc = "[G]it " .. hlp })
			end
			map("<leader>gh", ":Gitsigns preview_hunk<CR>", "preview [H]unk")
			map("<leader>gn", ":Gitsigns next_hunk<CR>", "[N]ext hunk")
			map("<leader>gp", ":Gitsigns prev_hunk<CR>", "[P]revious hunk")
			map("<leader>gd", ":Gitsigns diffthis HEAD~1<CR>", "[D]iff")
		end,
	},
}
