return {
	"mbbill/undotree",
	cond = not vim.g.vscode,
	keys = {
		{
			"<leader>u",
			vim.cmd.UndotreeToggle,
			desc = "Toggle Undotree",
		},
	},
}
