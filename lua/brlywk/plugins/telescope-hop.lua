return {
	"nvim-telescope/telescope-hop.nvim",
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			extensions = {
				hop = {
					trace_entry = true,
				},
			},
			defaults = {
				mappings = {
					["i"] = {
						["<C-space>"] = function(prompt_bufnr)
							telescope.extensions.hop.hop(prompt_bufnr)
						end,
						-- for some reason I need to set these here again, otherwise the ones
						-- in telescope.lua will not work anymore...
						-- TODO: Look into how Lua merges tables...
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("hop")
	end,
}
