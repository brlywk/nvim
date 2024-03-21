return {
	"sindrets/diffview.nvim",
	cond = not vim.g.vscode,
	config = function()
		vim.keymap.set("n", "<leader>gd", function()
			if _G.diffview_open then
				vim.cmd("DiffviewOpen")
			else
				vim.cmd("DiffviewClose")
			end

			_G.diffview_open = not _G.diffview_open
		end, { desc = "Toggle Diffview" })
	end,
}
