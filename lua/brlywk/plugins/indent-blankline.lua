return {
	"lukas-reineke/indent-blankline.nvim",
	-- cond = not vim.g.vscode,
	main = "ibl",
	opts = {
		indent = {
			char = "▏",
		},
		exclude = {
			filetypes = {
				"aerial",
				"alpha",
				"dashboard",
				"trouble",
			},
		},
	},
}
