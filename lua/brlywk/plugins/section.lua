return {
	"brlywk/section.nvim",
	config = function()
		vim.keymap.set("n", "<space>cc", require("section").create_comment, { desc = "Create section comment" })
	end,
}
