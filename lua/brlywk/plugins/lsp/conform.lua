return {
	"stevearc/conform.nvim",
	cond = not vim.g.vscode,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- define some of the sublist to make sure the faster formatter is tried first
		local prettier = { "prettierd", "prettier" }
		local eslint = { "eslint_d", "eslint" }

		require("conform").setup({
			-- configure which formatter to use
			-- Note: sublists are used to specify the first formatter found to be used,
			-- otherwise in a list all formatters are run in sequence

			formatters_by_ft = {
				html = { prettier },
				css = { prettier },
				scss = { prettier },

				javascript = { prettier },
				typescript = { prettier },
				javascriptreact = { prettier },
				typescriptreact = { prettier },

				astro = { prettier },
				svelte = { prettier },
				-- we have to disable prettier for vue as it's clashing with how
				-- vue templates should be formatted
				vue = { eslint },

				json = prettier,
				markdown = prettier,
				yaml = { "yamlfix" },
				toml = { "taplo" },
				lua = { "stylua" },

				go = { "gofumpt" },
				rust = { "rustfmt" },
				python = { "blue" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		-- keymap to trigger formatting manually
		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			--- @diagnostic disable-next-line:undefined-global
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (visual mode)" })
	end,
}
