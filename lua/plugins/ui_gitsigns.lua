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
        on_attach = function(bufnr)
            local gitsigns = require "gitsigns"

            vim.keymap.set(
                "n",
                "<leader>gb",
                gitsigns.toggle_current_line_blame,
                { desc = "Toggle line blame", noremap = true, silent = true, buffer = bufnr }
            )
        end,
    },
}
