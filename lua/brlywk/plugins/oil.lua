return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			skip_confirm_for_simple_edits = true,
			delete_to_trash = "true",

			view_options = {
				show_hidden = false,
				-- I rarely if ever want to see the node_modules folder...
				is_hidden_file = function(name, _)
					local startsWithDot = vim.startswith(name, ".")
					local nodeModules = vim.startswith(name, "node_modules")

					return startsWithDot or nodeModules
				end,
			},
		})

		vim.keymap.set(
			"n",
			"<leader>fe",
			":Oil --float<CR>",
			{ noremap = true, silent = true, desc = "File Explorer (Oil)" }
		)
	end,
}
