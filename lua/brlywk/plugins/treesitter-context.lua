return {
	"nvim-treesitter/nvim-treesitter-context",
	cond = not vim.g.vscode,
	opts = {
		separator = "─",
		max_lines = 3,
	},
}
