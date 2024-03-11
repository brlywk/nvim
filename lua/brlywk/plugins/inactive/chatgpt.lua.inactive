return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "op read op://Personal/OpenAI/api-key --no-newline",
			})

			vim.keymap.set("n", "<leader>cgg", "<cmd>:ChatGPT<CR>", { desc = "ChatGPT" })
			vim.keymap.set(
				"n",
				"<leader>cgi",
				"<cmd>:ChatGPTEditWithInstructions<CR>",
				{ desc = "ChatGPT: Edit with instructions" }
			)
			vim.keymap.set("n", "<leader>cgb", "<cmd>:ChatGPTRun fix_bugs<CR>", { desc = "ChatGPT: Fix Bugs" })
			vim.keymap.set("n", "<leader>cge", "<cmd>:ChatGPTRun explain_code<CR>", { desc = "ChatGPT: Explain Code" })
			vim.keymap.set(
				"n",
				"<leader>cgo",
				"<cmd>:ChatGPTRun optimize_code<CR>",
				{ desc = "ChatGPT: Optimize Code" }
			)
			vim.keymap.set("n", "<leader>cgd", "<cmd>:ChatGPTRun docstring<CR>", { desc = "ChatGPT: Docstring" })
			vim.keymap.set("n", "<leader>cgt", "<cmd>:ChatGPTRun add_tests<CR>", { desc = "ChatGPT: Add Tests" })
		end,
	},
}
