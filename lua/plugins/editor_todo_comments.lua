return {
    "folke/todo-comments.nvim",
    enabled = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        ---- Setup ----
        local todo_comments = require "todo-comments"
        todo_comments.setup {
            keywords = {
                DEBUG = { icon = "󱂦 ", color = "info" },
            },
        }

        ---- Keymaps ----
        local set = vim.keymap.set
        local opts = { noremap = true, silent = true }

        opts.desc = "Find comments"
        set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", opts)

        opts.desc = "Find Todo/Fix/Fixme comments"
        set("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", opts)

        opts.desc = "Find Debug comments"
        set("n", "<leader>fD", "<cmd>TodoTelescope keywords=DEBUG<CR>", opts)
    end,
}
