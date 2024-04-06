return {
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Documents", "~/Projects", "~/Downloads", "/" },
			})
			require("lualine").setup({
				sections = { lualine_c = { require("auto-session.lib").current_session_name } },
			})
		end,
	},
	{
		"rmagatti/session-lens",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"rmagatti/auto-session",
		},

		config = function()
			require("session-lens").setup({
				prompt_title = "Saved sessions",
				--				theme = 'ivy',
				theme_conf = { border = true },
				previewer = false,
			})
			vim.keymap.set("n", "<leader>fs", ":SearchSession<CR>", { desc = "[F]uzzy-search saved [S]essions" })
		end,
	},
}
