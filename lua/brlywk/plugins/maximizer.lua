return {
	"declancm/maximize.nvim",
	cond = not vim.g.vscode,
	config = function()
		require("maximize").setup()

		vim.keymap.set("n", "<leader>wm", "<cmd>lua require('maximize').toggle()<CR>", { desc = "Maximize Window" })
	end,
}
