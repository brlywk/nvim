--- @diagnostic disable:assign-type-mismatch
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

        notifier = {
            enabled = true,
            filter = function(n)
                -- disabled; LSP hover triggers this notification
                return n.msg ~= "No information available"
            end,
        },

        picker = { enabled = true },

        quickfile = { enabled = true },

        scope = { enabled = true },

        scroll = { enabled = false },

        statuscolumn = { enabled = false },

        styles = {
            ---@diagnostic disable-next-line:missing-fields
            lazygit_borders = {
                border = require("config.plugins").border_style,
                title = "LazyGit",
                title_pos = "center",
            },
        },

        words = { enabled = false },
    },

    ---- Keymaps ----
    keys = {
        ---- Pickers ----
        {
            "<leader>/",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart find",
        },
        {
            "<leader>?",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>u",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo history",
        },
        {
            "<leader><leader>i",
            function()
                Snacks.picker.icons()
            end,
            desc = "Insert symbol",
        },
        {
            "<leader><leader>t",
            function()
                Snacks.terminal()
            end,
            desc = "Terminal",
        },

        -- buffers
        {
            "<leader>bb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Open buffers",
        },
        {
            "<leader>bl",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer lines",
        },
        {
            "<leader>bg",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep open buffers",
        },

        -- find files
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find files",
        },
        {
            "<leader>fW",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Grep word",
        },
        {
            "<leader>fE",
            function()
                Snacks.picker.explorer()
            end,
            desc = "File explorer panel",
        },

        -- LSP
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto declaration",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto implementation",
        },
        {
            "gy",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto t[y]pe definition",
        },
        {
            "<leader>cs",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP symbols",
        },
        {
            "<leader>cS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP workspace symbols",
        },
        {
            "<leader>cd",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Diagnostics (buffer)",
        },
        {
            "<leader>cD",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics (project)",
        },

        -- git
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "LazyGit",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git branches",
        },
        {
            "<leader>gf",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Git files",
        },
        {
            "<leader>gl",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Git log",
        },
        {
            "<leader>gL",
            function()
                Snacks.lazygit.log_file()
            end,
            desc = "Git log (file)",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git branches",
        },
        {
            "<leader>gB",
            function()
                Snacks.picker.git_log_line()
            end,
            desc = "Git blame",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git status",
        },
        {
            "<leader>gS",
            function()
                Snacks.picker.git_stash()
            end,
            desc = "Git stash",
        },
        {
            "<leader>gd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git diff (hunks)",
        },

        -- vim stuff
        {
            "<leader>vc",
            function()
                Snacks.picker.files { cwd = vim.fn.stdpath "config" }
            end,
            desc = "Config files",
        },
        {
            "<leader>vC",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>vh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help",
        },
        {
            "<leader>vH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Highlight groups",
        },
        {
            "<leader>vk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>vn",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notifications",
        },
        {
            "<leader>va",
            function()
                Snacks.picker.autocmds()
            end,
            desc = "Autocmds",
        },
        {
            "<leader>vp",
            function()
                Snacks.picker.lazy()
            end,
            desc = "Plugins",
        },
        {
            "<leader>vr",
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>vj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Jumps",
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
