return {
	-- automatically infer tabwidth and all that crap
	{ "tpope/vim-sleuth" },

	-- Easy use of Git commands
	{
		"tpope/vim-fugitive",
		cond = not vim.g.vscode,
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status (fugitive)" })
			vim.keymap.set("n", "<leader>gc", function()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":Git ", true, true, true), "n", true)
			end, { desc = "Git command..." })
		end,
	},

	-- GitHub extensions for fugitive
	{ "tpope/vim-rhubarb", cond = not vim.g.vscode },

	-- Useful terminal commands within git
	{ "tpope/vim-eunuch", cond = not vim.g.vscode },

	-- surround commands
	-- { "tpope/vim-surround", cond = not vim.g.vscode },
	-- not tpope, but a newer replacement specifically for nvim
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
}
