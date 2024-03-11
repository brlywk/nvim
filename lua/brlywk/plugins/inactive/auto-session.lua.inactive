return {
	"rmagatti/auto-session",
	cond = not vim.g.vscode,
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>vr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>vs", "<cmd>SessionSave<CR>", { desc = "Save session for root dir" })
	end,
}
