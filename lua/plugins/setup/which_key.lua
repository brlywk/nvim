--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
require("which-key").setup {
    preset = "helix",
    show_help = false,
    plugins = {
        marks = false,
        registers = false,
    },
    win = {
        border = require("plugins.theme").border_style,
    },
    spec = {
        -- add names for groups
        { "<leader><leader>", group = "global" },
        { "<leader>c", group = "code" },
        { "<leader>b", group = "buffer" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        -- keep <leader>l free for "Language: <Language>" usage
        { "<leader>t", group = "test" },
        { "<leader>v", group = "vim internal" },
        { "<leader>w", group = "window" },
        { "<leader>x", group = "trouble" },
    },
}

--------------------------------------------------------------------------------
-- Keymap
--------------------------------------------------------------------------------
local set_opts = require("config.helper").set_opts
vim.keymap.set("n", "<leader><leader>?", function() end, set_opts "Buffer Local Keymaps (which-key)")
