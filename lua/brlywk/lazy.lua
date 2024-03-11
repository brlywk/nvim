local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	{ { import = "brlywk.plugins" }, { import = "brlywk.plugins.lsp" }, { import = "brlywk.plugins.debug" } },
	{
		ui = {
			icons = {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				source = "📄",
				start = "🚀",
				task = "📌",
			},
			border = "single",
		},
		-- dev = {
		-- 	path = "/Users/christoph/Programming/Misc/nvim_plugins",
		-- },
	}
)

-- Add convenient keymap to open lazyvim
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy.vim Plugin Manager" })
