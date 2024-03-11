return {
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()

			-- keymaps
			-- open floating terminal
			vim.keymap.set("n", "<A-f>", function()
				require("nvterm.terminal").toggle("float")
			end, {})
			-- close floating terminal
			vim.keymap.set("t", "<A-f>", function()
				require("nvterm.terminal").toggle("float")
			end, {})
		end,
	},
}
