return {
	"nvim-neotest/neotest",
	cond = not vim.g.vscode,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- adapters
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	event = "VeryLazy",
	config = function()
		-- neotest-go setup
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		-- setup neotest and add adapters
		--- @diagnostic disable:missing-fields
		require("neotest").setup({
			adapters = {
				-- Go
				-- https://github.com/nvim-neotest/neotest-go
				require("neotest-go"),
				-- JS Jest
				-- https://github.com/nvim-neotest/neotest-jest
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						print("neotest-jest path: " .. path)
						return vim.fn.getcwd()
					end,
				}),
				-- JS Vitest
				-- https://github.com/marilari88/neotest-vitest
				require("neotest-vitest"),
			},
		})

		-- keymaps
		local k = vim.keymap
		local opts = { silent = true, desc = "" }

		opts.desc = "Open summary"
		k.set("n", "<leader>ts", ":lua require('neotest').summary.toggle()<CR>", opts)

		opts.desc = "Open output"
		k.set("n", "<leader>to", ":lua require('neotest').output.open({enter = true, auto_close = true})<CR>", opts)

		opts.desc = "Toggle output panel"
		k.set("n", "<leader>tp", ":lua require('neotest').output_panel.toggle()<CR>", opts)

		opts.desc = "Run nearest test"
		k.set("n", "<leader>tr", ":lua require('neotest').run.run()<CR>", opts)

		opts.desc = "Run all tests in file"
		k.set("n", "<leader>tR", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts)

		opts.desc = "Cancel test run"
		k.set("n", "<leader>tC", ":lua require('neotest').run.stop()<CR>", opts)

		opts.desc = "Toggle watching test"
		k.set("n", "<leader>tw", ":lua require('neotest').watch.toggle()", opts)

		opts.desc = "Toggle watching file"
		k.set("n", "<leader>tW", ":lua require('neotest').watch.toggle(vim.fn.expand('%'))", opts)
	end,
}
