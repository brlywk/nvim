return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },

        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "e", desc = "File Explorer", action = ":Oil" },
                    {
                        icon = " ",
                        key = "g",
                        desc = "Find Text",
                        action = ":lua Snacks.dashboard.pick('live_grep')",
                    },
                    {
                        icon = " ",
                        key = "r",
                        desc = "Recent Files",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    {
                        icon = "󰒲 ",
                        key = "L",
                        desc = "Lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
        },

        explorer = { enabled = true },

        indent = { enabled = true },

        input = { enabled = true },

        lazygit = {
            win = {
                style = "lazygit_borders",
            },
        },

        notifier = { enabled = true },

        picker = { enabled = true },

        quickfile = { enabled = true },

        scope = { enabled = true },

        scroll = { enabled = false },

        statuscolumn = { enabled = true },

        styles = {
            ---@diagnostic disable-next-line:missing-fields
            lazygit_borders = {
                border = "rounded",
                title = "LazyGit",
                title_pos = "center",
                backdrop = { transparent = true, blend = 20 },
            },
        },

        words = { enabled = false },
    },

    keys = {
        -- Pickers
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find files",
        },
        {
            "<leader>fH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Find hightlights",
        },
    },
    init = function()
        -- deactive animations
        vim.g.snacks_animate = false
    end,
    config = function(_, opts)
        require("snacks").setup(opts)

        -- set different highlight group for Dashboard to get a nicer link color
        -- for the one and only color scheme
        Snacks.util.set_hl({
            Desc = "Normal",
            Icon = "Directory",
            Header = "FlashLabel",
        }, { prefix = "SnacksDashboard", default = false })
    end,
}
