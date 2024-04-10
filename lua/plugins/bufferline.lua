local ret = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({
			options = {
				--mode = "tabs",
				separator_style = "thin", -- "slant",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = false,
					},
				},
			},
		})
		-- Switch tabs
		vim.cmd([[nnoremap <silent> <M-S-Left>  :BufferLineCyclePrev<CR>]])
		vim.cmd([[nnoremap <silent> <M-S-Right> :BufferLineCycleNext<CR>]])
		vim.cmd([[nnoremap <silent> <S-tab> :BufferLineCycleNext<CR>]])
		local keymap = vim.keymap
		keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "[B]ufferline close [O]thers" })
		keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "[B]ufferline close to the [R]ight" })
		keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "[B]ufferline close to the [L]eft" })
		keymap.set("n", "<leader>bp", "<cmd>BufferLinePickClose<CR>", { desc = "[B]ufferline [P]ick to close" })
	end,
}

return {}
