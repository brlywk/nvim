return {
	"williamboman/mason.nvim",
	-- cond = not vim.g.vscode,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		{
			"neovim/nvim-lspconfig",
			config = function()
				-- for some reason lazy.nvim is HELLBENT on running a config function,
				-- even though the plugin does not provide one.
				-- So here you go Lazy.nvim... an empty config function just so you can
				-- kindly f*** off
			end,
		},
		"folke/neoconf.nvim",
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		------- Mason Config ----------------------------
		local mason = require("mason")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "single",
			},
		})
		-- set keymap
		vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Mason" })

		------- Neoconf Config --------------------------
		local neoconf = require("neoconf")
		neoconf.setup({})
		require("neodev").setup({})

		------- Mason LspConfig -------------------------
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = {
				"astro",
				"cssls",
				"emmet_ls",
				"gopls",
				"html",
				-- "htmx-lsp",
				"lua_ls",
				-- "rust_analyzer",
				-- "svelte",
				"tailwindcss",
				-- "taplo", -- TOML
				"templ", -- Go Templ package
				"tsserver",
				-- "typos_lsp" -- Spell checking,
				"volar",
				-- "yamlls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = false, -- not the same as ensure_installed
		})

		------- LspConfig -------------------------------
		local lspconfig = require("lspconfig")

		-- globally override floating windows to have a border
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = "single"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation (cursor)"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>cR", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			opts.desc = "Organize Imports"
			keymap.set("n", "<leader>ci", ":OrganizeImports<CR>", opts)

			opts.desc = "Format Code"
			keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)

			opts.desc = "Signature Help"
			keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-------- LSP SERVER CONFIG -----------------------

		-- load lsp server settings
		local lsp_settings = require("brlywk.config.lsp.settings")

		-- default configuration for all LSPs
		local default_config = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- helper to check with neoconf if server should be skipped
		local function is_disabled(skip_server_name)
			return neoconf.get(skip_server_name .. ".disable")
		end

		-- conceptually these settings should probably be loaded from the actual
		-- config file, but I only have one use case for this right now...
		-- local function is_modified(cond_server_name)
		-- 	return neoconf.get(cond_server_name .. ".modify")
		-- end

		-- setup lsp servers
		mason_lspconfig.setup_handlers({
			function(server_name)
				-- skip disabled LSPs
				if is_disabled(server_name) then
					return
				end

				-- get specific config or empty table
				local server_config = lsp_settings.server_settings[server_name] or {}

				-- merge with default settings, prioritizing specific server settings
				server_config = vim.tbl_deep_extend("keep", server_config, default_config)

				-- if neoconf indicates modified settings, merge these in, too
				-- if is_modified(server_name) and vim.tbl_get(modified_settings, server_name) then
				local modified_settings = neoconf.get(server_name, {})
				if not vim.tbl_isempty(modified_settings) then
					server_config = vim.tbl_deep_extend("force", server_config, modified_settings)
					-- print(server_name .. " config: " .. vim.inspect(server_config))
				end

				-- run lspconfig for server
				lspconfig[server_name].setup(server_config)
			end,
		})
	end,
}
