--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
-- deactivate animations
vim.g.snacks_animate = false

require("snacks").setup {
    bigfile = { enabled = true },

    dashboard = {
        enabled = true,
        sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
        },
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
            -- hide the following messages
            local ignored_messages = {
                -- tends to happen when "hover" over code returns no results
                ["No information available"] = true,
                -- some LSPs (looking at you ZLS) are very "yappy" if no
                -- code actions can be found for the current file
                ["No code actions available"] = true,
            }

            return not ignored_messages[n.msg]
        end,
    },

    picker = {
        enabled = true,
        exclude = { "node_modules", "**/*.gd.uid" },
    },

    quickfile = { enabled = true },

    scope = { enabled = true },

    scroll = { enabled = false },

    statuscolumn = { enabled = false },

    styles = {
        ---@diagnostic disable-next-line:missing-fields
        lazygit_borders = {
            border = require("plugins.theme").border_style,
            title = "LazyGit",
            title_pos = "center",
        },
    },

    words = { enabled = false },
}

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
local set = vim.keymap.set
local set_opts = require("config.helper").set_opts

-- pickers
set("n", "<leader>?", function()
    Snacks.picker.smart()
end, set_opts "Smart find")
set("n", "<leader>/", function()
    Snacks.picker.grep()
end, set_opts "Grep")
set("n", "<leader>u", function()
    Snacks.picker.undo()
end, set_opts "Undo history")
set("n", "<leader><leader>i", function()
    Snacks.picker.icons()
end, set_opts "Insert symbol")
set("n", "<leader><leader>T", function()
    Snacks.terminal()
end, set_opts "Terminal split")

-- buffers
set("n", "<leader>bb", function()
    Snacks.picker.buffers()
end, set_opts "Open buffers")
set("n", "<leader>bl", function()
    Snacks.picker.lines()
end, set_opts "Buffer lines")
set("n", "<leader>bg", function()
    Snacks.picker.grep_buffers()
end, set_opts "Grep open buffers")

-- find files
set("n", "<leader>ff", function()
    Snacks.picker.files()
end, set_opts "Find files")
set("n", "<leader>fW", function()
    Snacks.picker.grep_word()
end, set_opts "Grep word")
set("n", "<leader>fE", function()
    Snacks.picker.explorer()
end, set_opts "File explorer panel")

-- lsp
set("n", "gd", function()
    Snacks.picker.lsp_definitions()
end, set_opts "Goto definition")
set("n", "gD", function()
    Snacks.picker.lsp_declarations()
end, set_opts "Goto declaration")
set("n", "gr", function()
    Snacks.picker.lsp_references()
end, set_opts "References")
set("n", "gI", function()
    Snacks.picker.lsp_implementations()
end, set_opts "Goto implementation")
set("n", "gy", function()
    Snacks.picker.lsp_type_definitions()
end, set_opts "Goto t[y]pe definition")
set("n", "<leader>fs", function()
    Snacks.picker.lsp_symbols()
end, set_opts "LSP symbols")
set("n", "<leader>fS", function()
    Snacks.picker.lsp_workspace_symbols()
end, set_opts "LSP workspace symbols")
set("n", "<leader>cd", function()
    Snacks.picker.diagnostics_buffer()
end, set_opts "Diagnostics (buffer)")
set("n", "<leader>cD", function()
    Snacks.picker.diagnostics()
end, set_opts "Diagnostics (project)")

-- git
set("n", "<leader>gg", function()
    Snacks.lazygit()
end, set_opts "LazyGit")
set("n", "<leader>gb", function()
    Snacks.picker.git_branches()
end, set_opts "Git branches")
set("n", "<leader>gf", function()
    Snacks.picker.git_files()
end, set_opts "Git files")
set("n", "<leader>gl", function()
    Snacks.lazygit.log()
end, set_opts "Git log")
set("n", "<leader>gL", function()
    Snacks.lazygit.log_file()
end, set_opts "Git log (file)")
set("n", "<leader>gB", function()
    Snacks.picker.git_log_line()
end, set_opts "Git blame")
set("n", "<leader>gs", function()
    Snacks.picker.git_status()
end, set_opts "Git status")
set("n", "<leader>gS", function()
    Snacks.picker.git_stash()
end, set_opts "Git stash")
set("n", "<leader>gd", function()
    Snacks.picker.git_diff()
end, set_opts "Git diff (hunks)")

-- vim
set("n", "<leader>vc", function()
    Snacks.picker.files { cwd = vim.fn.stdpath "config" }
end, set_opts "Config files")
set("n", "<leader>vC", function()
    Snacks.picker.commands()
end, set_opts "Commands")
set("n", "<leader>vh", function()
    Snacks.picker.help()
end, set_opts "Help")
set("n", "<leader>vH", function()
    Snacks.picker.highlights()
end, set_opts "Highlight groups")
set("n", "<leader>vk", function()
    Snacks.picker.keymaps()
end, set_opts "Keymaps")
set("n", "<leader>vn", function()
    Snacks.picker.notifications()
end, set_opts "Notifications")
set("n", "<leader>va", function()
    Snacks.picker.autocmds()
end, set_opts "Autocmds")
set("n", "<leader>vp", function()
    Snacks.picker.lazy()
end, set_opts "Plugins")
set("n", "<leader>vr", function()
    Snacks.picker.registers()
end, set_opts "Registers")
set("n", "<leader>vj", function()
    Snacks.picker.jumps()
end, set_opts "Jumps")

--------------------------------------------------------------------------------
-- Customization
--------------------------------------------------------------------------------
Snacks.util.set_hl({
    Desc = "Normal",
    Icon = "Directory",
    Header = "FlashLabel",
}, { prefix = "SnacksDashboard", default = false })
