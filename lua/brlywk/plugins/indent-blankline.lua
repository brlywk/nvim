return {
	"lukas-reineke/indent-blankline.nvim",
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
