return {
	"nvim-treesitter/nvim-treesitter-context",
	cond = not vim.g.vscode,
	opts = {
		max_lines = 3,
	},
	config = function(_, opts)
		require("treesitter-context").setup(opts)

		vim.cmd("highlight TreesitterContext guibg=NONE")
	end,
}
