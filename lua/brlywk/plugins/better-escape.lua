return {
	"max397574/better-escape.nvim",
	cond = not vim.g.vscode,
	config = function()
		require("better_escape").setup({
			mapping = { "jk", "kj" },
		})
	end,
}
