return {
	"folke/todo-comments.nvim",
	cond = not vim.g.vscode,
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	config = true,
	keys = {
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		{ "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		{ "<leader>fD", "<cmd>TodoTelescope keywords=DEBUG<cr>", desc = "Todo/Fix/Fixme" },
	},
	opts = {
		keywords = {
			DEBUG = { icon = "󱂦 ", color = "info" },
		},
	},
}
