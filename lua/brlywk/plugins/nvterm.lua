return {
	"NvChad/nvterm",
	cond = not vim.g.vscode,
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
}
