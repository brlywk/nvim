return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").open()
			end,
			desc = "Open Trouble",
		},
		{
			"<leader>xn",
			function()
				require("trouble").next()
			end,
			desc = "Trouble: Next",
		},
		{
			"<leader>xw",
			function()
				require("trouble").open("workspace_diagnostics")
			end,
			desc = "Trouble: Workspace Diagnostics",
		},
		{
			"<leader>xd",
			function()
				require("trouble").open("document_diagnostics")
			end,
			desc = "Trouble: Document Diagnostics",
		},
		{
			"<leader>xq",
			function()
				require("trouble").open("Quickfix")
			end,
			desc = "Trouble: Quickfix List",
		},
		{
			"<leader>xl",
			function()
				require("trouble").open("loclist")
			end,
			desc = "Trouble: Location List",
		},
		{
			"gR",
			function()
				require("trouble").open("lsp_references")
			end,
			desc = "Trouble: LSP References",
		},
	},
	opts = {},
}
