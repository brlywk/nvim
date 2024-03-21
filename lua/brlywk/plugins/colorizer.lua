return {
	"NvChad/nvim-colorizer.lua",
	cond = not vim.g.vscode,
	event = { "BufReadPre", "BufNewFile" },
	config = true,
}
