return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	build = ":TSUpdate",
	config = function()
		require("custom.config.treesitter")
	end,
	enabled = true,
}
