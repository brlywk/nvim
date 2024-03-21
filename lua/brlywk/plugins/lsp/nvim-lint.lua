return {
	"mfussenegger/nvim-lint",
	cond = not vim.g.vscode,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		-- configure linters
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			-- svelte = { "eslint_d" },
			vue = { "eslint_d" },
			astro = { "eslint_d" },
			-- python = { "pylint" },
			go = { "golangcilint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- automatically trigger linting
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- set keymap for manual linting
		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Lint current file" })
	end,
}
