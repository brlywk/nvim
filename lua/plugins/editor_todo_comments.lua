---@diagnostic disable:undefined-field
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
        set("n", "<leader>ft", function()
            Snacks.picker.todo_comments()
        end, opts)

        opts.desc = "Find Todo/Fix/Fixme comments"
        set("n", "<leader>fT", function()
            Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } }
        end, opts)

        opts.desc = "Find Debug comments"
        set("n", "<leader>fD", function()
            Snacks.picker.todo_comments { keywords = { "DEBUG" } }
        end, opts)
    end,
}
