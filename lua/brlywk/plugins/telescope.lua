return {
	"nvim-telescope/telescope.nvim",
	cond = not vim.g.vscode,
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					["i"] = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				file_ignore_patterns = { "node_modules", "target" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- activate native fuzzy search with fzf
		telescope.load_extension("fzf")
		-- replace native nvim select dialogue with telescope
		telescope.load_extension("ui-select")

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Find Open Buffers" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find document symbols" })
		keymap.set(
			"n",
			"<leader>fS",
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			{ desc = "Find workspace symbols" }
		)
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
		keymap.set("n", "<leader>fG", "<cmd>Telescope git_files<cr>", { desc = "Find files (Git)" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find grep (live)" })
		keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", { desc = "Find current word" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find in help" })
	end,
}
