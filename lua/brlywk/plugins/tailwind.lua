return {
	-- add tailwind support
	-- i.e. automatically install the server from now on
	{
		"neovim/nvim-lspconfig",
		cond = not vim.g.vscode,
		opts = {
			servers = {
				tailwindcss = {
					filetypes_exclude = { "markdown", "lua" },
				},
			},
			setup = {
				tailwindcss = function(_, opts)
					local tw = require("lspconfig.server_configurations.tailwindcss")
					--- @param ft string
					opts.filetypes = vim.tbl_filter(function(ft)
						return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
					end, tw.default_config.filetypes)
				end,
			},
		},
	},

	-- more tailwind: nicer colors in auto-complete
	{
		"hrsh7th/nvim-cmp",
		cond = not vim.g.vscode,
		dependencies = {
			"roobert/tailwindcss-colorizer-cmp.nvim",
			config = true,
		},
		opts = function(_, opts)
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item)
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},

	-- also add coloring options for some stuff
	{
		"NvChad/nvim-colorizer.lua",
		cond = not vim.g.vscode,
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},

	-- use tailwind-sorter
	{
		"laytan/tailwind-sorter.nvim",
		cond = not vim.g.vscode,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
		build = "cd formatter && npm i && npm run build",
		event = "VeryLazy",
		config = true,
		opts = {
			on_save_enabled = true,
			on_save_pattern = {
				"*.astro",
				"*.hbs",
				"*.heex",
				"*.html",
				"*.js",
				"*.jsx",
				"*.php",
				"*.tsx",
				"*.twig",
				"*.vue",
			},
		},
	},
}
