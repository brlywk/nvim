local M = {}

-- Custom function to organize imports for tsserver
M.organizeImports = function()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

-- LSP server settings
M.server_settings = {
	astro = {},
	cssls = {
		-- we need to ignore unknown @rules with tailwind...
		-- there should be a better solution for this though
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore",
				},
			},
		},
	},
	emmet_ls = {
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"vue",
			"astro",
		},
	},
	gopls = {},
	html = {},
	htmx = {},
	lua_ls = {
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
	pylsp = {},
	svelte = {},
	rust_analyzer = {
		settings = {
			["rust-analyzerq"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
	tailwindcss = {},
	taplo = {},
	templ = {},
	tsserver = {
		init_options = {
			preferences = {
				disableSuggestions = true,
			},
		},
		commands = {
			OrganizeImports = {
				M.organizeImports,
				description = "Organize Imports",
			},
		},
	},
	typos_lsp = {},
	volar = {},
	yamlls = {},
}

return M
