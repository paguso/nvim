-- LSP setup using Neovim's native API (vim.lsp.config / vim.lsp.enable, 0.11+).
-- nvim-lspconfig only provides the server definitions (its lsp/*.lua files);
-- the overrides below are merged on top of those defaults.
-- Completion capabilities are added automatically by blink.cmp.
return {
	"neovim/nvim-lspconfig",

	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- Lua LSP support for the Neovim config, runtime and plugins
		{ "folke/lazydev.nvim", ft = "lua", opts = { library = { "nvim-dap-ui" } } },
	},

	config = function()
		-- Per-server overrides
		vim.lsp.config("clangd", {
			filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp", "cuda" },
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
				"--background-index",
				"--clang-tidy",
				-- The critical flag for finding system headers
				"--query-driver=/usr/bin/gcc,/usr/bin/g++",
				"--header-insertion=never",
			},
		})

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace", -- Options: "openFilesOnly" or "workspace"
					},
				},
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		})

		-- Folding capability for every server
		vim.lsp.config("*", {
			capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			},
		})

		local servers = {
			"autotools_ls",
			"clangd",
			"gopls",
			"pyright",
			"texlab",
			"rust_analyzer",
			"lua_ls",
		}

		-- Ensure the servers and tools are installed (see :Mason)
		local ensure_installed = vim.list_extend(vim.deepcopy(servers), {
			"stylua", -- Used to format lua code
			"codelldb",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- mason-lspconfig v2 just calls vim.lsp.enable() for installed servers
		require("mason-lspconfig").setup()

		-- Explicit enable: also covers servers installed outside mason
		vim.lsp.enable(servers)

		--  This function gets run when an LSP attaches to a particular buffer.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				local tb = require("telescope.builtin")
				map("gd", tb.lsp_definitions, "[G]oto [D]efinition")
				map("gr", tb.lsp_references, "[G]oto [R]eferences")
				map("gI", tb.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", tb.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", tb.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", tb.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Highlight references of the word under the cursor
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument/documentHighlight") then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})
	end,
}
