return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Creates a beautiful debugger UI
			"rcarriga/nvim-dap-ui",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
		},

		config = function()
			local dap = require("dap")

			--[[ -- required gdb 14
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			} ]]

			--[[ dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtBeginningOfMainSubprogram = true,
				},
			} ]]

			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode-14",
				name = "lldb",
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}

			local dbgcontinue = function()
				if vim.fn.filereadable(".vscode/launch.json") then
					require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp" } })
				end
				require("dap").continue()
			end

			--require("dap.ext.vscode").load_launchjs(nil, {})

			vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>", { desc = "Debug toggle breakpoint" })
			vim.keymap.set("n", "<F8>", ":DapToggleBreakpoint<CR>", { desc = "Debug toggle breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
			vim.keymap.set("n", "<Leader>dc", dbgcontinue, { desc = "Debug continue" })
			vim.keymap.set("n", "<F5>", dbgcontinue, { desc = "Debug continue" })
			vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>", { desc = "Debug step over" })
			vim.keymap.set("n", "<F10>", ":DapStepOver<CR>", { desc = "Debug step over" })
			vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>", { desc = "Debug step into" })
			vim.keymap.set("n", "<F11>", ":DapStepInto<CR>", { desc = "Debug step into" })
			vim.keymap.set("n", "<leader>dt", ":DapTerminate<CR>", { desc = "Debug terminate" })
			vim.keymap.set("n", "<S-F5>", ":DapTerminate<CR>", { desc = "Debug terminate" })

			-- Initialize specific servers
			require("dap-go").setup()
			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
		end,
	},
	{
		"folke/neodev.nvim",
		ops = {},
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
				--...,
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed

			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"cpptools",
				"delve",
				"debugpy",
			},
		},
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "", collapsed = "", current_frame = "" },
				controls = {
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_out = "",
						step_over = "",
						step_back = "",
						run_last = "▶▶",
						terminate = "",
						disconnect = "⏏",
					},
				},
			})

			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
			vim.keymap.set("n", "<M-k>", dapui.eval, { desc = "Debug: evaluate expression under cursor" })
			-- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			--vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
			--vim.fn.sign_define("DapStopped", { text = "▶️,", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
		end,
	},
}
