return {
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.vscode,
    opts = {
        sign_priority = 15,
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
    },
}
