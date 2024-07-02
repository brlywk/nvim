----- config -----

local ensure_installed = {
    "lua",
    "go",
    "rust",

    "html",
    "css",

    "javascript",
    "typescript",
    "tsx",
    "json",
    "jsdoc",

    "astro",

    "markdown",
    "markdown_inline",

    "yaml",
    "toml",

    "bash",
    "gitignore",
}

----- setup -----

--- @diagnostic disable:missing-fields
require("nvim-treesitter.configs").setup {
    -- syntax highlighting
    highlight = {
        enable = true,
    },

    -- install parsers synchronously
    sync_install = false,

    -- automatically install additional parsers when entering a buffer
    auto_install = true,

    -- always install the following parsers
    ensure_installed = ensure_installed,

    -- enable incremental selection
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },

    -- textobjects settings
    textobjects = require "custom.config.treesitter_textobjects",
}

----- keymaps -----

local set = vim.keymap.set
-- enable repetition of treesitter move with ; and ,
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- in addition to mini, also allow ; and , to repeat search with f and t
set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
