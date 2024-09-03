-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
--
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			color_overrides = {
-- 				mocha = {
-- 					base = "#21252b",
-- 					mantle = "#000000",
-- 					crust = "#000000",
-- 				},
-- 			},
-- 		})
-- 		vim.cmd.colorscheme("catppuccin-mocha")
-- 	end,
-- }

-- return {
-- 	"EdenEast/nightfox.nvim",
-- 	config = function()
-- 		require("nightfox").setup({
-- 			options = {
-- 				dim_inactive = true,
-- 				styles = {
-- 					comments = "italic",
-- 					--keywords = "bold",
-- 					types = "bold",
-- 				},
-- 			},
-- 		})
-- 		vim.cmd([[colorscheme nordfox]])
-- 	end,
-- }

return {
	"gbprod/nord.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nord").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			transparent = false, -- Enable this to disable setting the background color
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
			nord_bold = true,
			borders = true, -- Enable the border between verticaly split windows visible
			errors = { mode = "bg" }, -- Display mode for errors and diagnostics
			-- values : [bg|fg|none]
			search = { theme = "vim" }, -- theme for highlighting search results
			-- values : [vim|vscode]
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				types = { bold = true },
				keywords = {},
				functions = {},
				variables = {},

				-- To customize lualine/bufferline
				bufferline = {
					current = {},
					modified = { italic = true },
				},
			},

			--- You can override specific highlights to use other groups or a hex color
			--- function will be called with all highlights and the colorScheme table
			on_highlights = function(highlights, colors) end,
		})
		vim.cmd([[colorscheme nord]])
	end,
}

-- return {
-- 	"cpea2506/one_monokai.nvim",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		require("one_monokai").setup({
-- 			transparent = false,
-- 			colors = {},
-- 			themes = function(colors)
-- 				return {}
-- 			end,
-- 			italics = true,
-- 		})
-- 		vim.cmd([[colorscheme one_monokai]])
-- 	end,
-- }
