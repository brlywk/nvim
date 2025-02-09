return {
    "lewis6991/gitsigns.nvim",
    enabled = true,
    opts = {
        -- right between todo and dap
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
