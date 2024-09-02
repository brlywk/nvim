return {
	"S1M0N38/love2d.nvim",
	enabled = true,
	cmd = "LoveRun",
	opts = {
		restart_on_save = false, -- feels a little bit clunky
	},
	keys = {
		{ "<leader>v", ft = "lua", desc = "LÖVE" },
		{ "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
		{ "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
	},
}
