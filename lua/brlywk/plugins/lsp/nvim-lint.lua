return {
	"mfussenegger/nvim-lint",
	cond = not vim.g.vscode,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		-- NOTE: eslint_d does not seem to have received updates in some time, so
		-- use eslint for linting again; NEEDS TO BE INSTALLED AS A DEV DEPENDENCY THOUGH!
		local eslint = "eslint"

		-- configure linters
		lint.linters_by_ft = {
			javascript = { eslint },
			typescript = { eslint },
			javascriptreact = { eslint },
			typescriptreact = { eslint },

			vue = { "biomejs" },
			astro = { eslint },
			svelte = { eslint },

			go = { "golangcilint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- automatically trigger linting
		if linter_active then
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- use neoconf to check if linter should be attached or not
					local neoconf = require("neoconf")
					neoconf.setup({})
					local linter_active = neoconf.get("linter", { linter = true })
					if linter_active then
						lint.try_lint()
					end
				end,
			})

			-- set keymap for manual linting
			vim.keymap.set("n", "<leader>cl", function()
				lint.try_lint()
			end, { desc = "Lint current file" })
		end
	end,
}
