return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = not vim.g.vscode,
    opts = {
        preset = "helix",
        show_help = false,
        plugins = {
            marks = false,
            registers = false,
        },
        win = {
            border = require("config.plugins").border_style,
        },
        spec = {
            -- add names for groups
            { "<leader><leader>", group = "global" },
            { "<leader>c", group = "code" },
            { "<leader>b", group = "buffer" },
            { "<leader>f", group = "file/find" },
            { "<leader>g", group = "git" },
            -- Keep <leader>l free for "Language: <Language>" usage (see go.lua)
            { "<leader>t", group = "test" },
            { "<leader>v", group = "vim internal" },
            { "<leader>w", group = "window" },
            { "<leader>x", group = "trouble" },
        },
    },
    keys = {
        {
            "<leader><leader>?",
            function()
                require("which-key").show { global = false }
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
