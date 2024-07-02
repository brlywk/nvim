return {
	"folke/trouble.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Trouble",
	config = function()
		require("custom.config.trouble")
	end,
	enabled = true,
}
