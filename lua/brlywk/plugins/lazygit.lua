return {
	{
		"kdheepak/lazygit.nvim",
		cond = not vim.g.vscode,
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>gg",
				":LazyGit<CR>",
				desc = "LazyGit",
			},
		},
	},
}
