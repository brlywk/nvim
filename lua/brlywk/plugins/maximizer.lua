return {
	"declancm/maximize.nvim",
	config = function()
		require("maximize").setup()

		vim.keymap.set("n", "<leader>wm", "<cmd>lua require('maximize').toggle()<CR>", { desc = "Maximize Window" })
	end,
}
