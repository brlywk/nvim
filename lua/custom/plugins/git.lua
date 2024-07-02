return {
	"NeogitOrg/neogit",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"lewis6991/gitsigns.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("custom.config.git")
	end,
	enabled = true,
}
