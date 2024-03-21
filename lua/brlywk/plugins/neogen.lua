return {
	"danymat/neogen",
	cond = not vim.g.vscode,
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		local ng = require("neogen")

		ng.setup({
			snippet_engine = "luasnip",
		})

		vim.keymap.set(
			"n",
			"<leader>cn",
			":lua require('neogen').generate()<CR>",
			{ noremap = true, silent = true, desc = "Neogen" }
		)
	end,
}
