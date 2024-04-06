return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>hl", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[H]arpoon [L] Window" })

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():append()
		end, { desc = "[H]arpoon [A]ppend" })

		vim.keymap.set("n", "<leader>h1", function()
			harpoon:list():select(1)
		end, { desc = "[H]arpoon select item #[1]" })

		vim.keymap.set("n", "<leader>h2", function()
			harpoon:list():select(2)
		end, { desc = "[H]arpoon select item #[2]" })

		vim.keymap.set("n", "<leader>h3", function()
			harpoon:list():select(1)
		end, { desc = "[H]arpoon select item #[3]" })

		vim.keymap.set("n", "<leader>h4", function()
			harpoon:list():select(1)
		end, { desc = "[H]arpoon select item #[4]" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "[H]arpoon [P]revious" })

		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "[H]arpoon [N]ext" })
	end,
}
