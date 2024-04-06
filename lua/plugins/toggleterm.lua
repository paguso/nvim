return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = { --[[ things you want to change go here]]
		},

		config = function()
			require("toggleterm").setup({
				-- size can be a number or function which is passed the current terminal
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<c-\>]],
				hide_numbers = true, -- hide the number column in toggleterm buffers
				shade_filetypes = {},
				autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
				direction = "horizontal", -- "vertical" | "horizontal" | "tab" | "float",
				close_on_exit = true, -- close the terminal window when the process exits
				-- Change the default shell. Can be a string or a function returning a string
				shell = vim.o.shell,
				auto_scroll = true, -- automatically scroll to the bottom on terminal output
				-- This field is only relevant if direction is set to 'float'
				winbar = {
					enabled = false,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
			})

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts, {desc = "Back to normal mode"})
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
			

			local Terminal=require("toggleterm.terminal").Terminal
			-- Python Terminal
			local python_term = Terminal:new({cmd="python3", direction="float"})

			function _TOGGLE_PYTHON_TERM()
				python_term:toggle()
			end
		end,
	},
}
