return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
		config = function(_, opts)
			require("copilot").setup(opts)
			vim.g.copilot_enabled = 0

			-- keymap to activate / deactivate Copilot
			vim.keymap.set("n", "<leader>cp", function()
				if vim.g.copilot_enabled == 1 then
					vim.cmd("Copilot disable")
					vim.g.copilot_enabled = 0
				else
					vim.cmd("Copilot enable")
					vim.g.copilot_enabled = 1
				end
			end, { desc = "Toggle Copilot on/off" })

			-- Deactivate by default... better for learning
			vim.cmd("Copilot disable")
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			local cmp = require("copilot_cmp")

			local has_words_before = function()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end
			cmp.setup({
				mapping = {
					["<Tab>"] = vim.schedule_wrap(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							fallback()
						end
					end),
				},
			})
		end,
	},

	-- enable lualine integration
	{
		"AndreM222/copilot-lualine",
	},
}
