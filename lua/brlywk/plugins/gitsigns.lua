return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			-- right between todo and dap
			sign_priority = 15,
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			on_attach = function(bufnr)
				-- set up keymaps
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Actions
				map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Toggle Blame Current Line" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { desc = "Diff this commit" })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
