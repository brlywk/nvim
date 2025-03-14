return {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        {
            "folke/ts-comments.nvim",
            opts = {},
            event = "VeryLazy",
            enabled = vim.fn.has "nvim-0.10.0" == 1,
        },
        {
            "bezhermoso/tree-sitter-ghostty",
            build = "make nvim_install",
        },
    },
    build = ":TSUpdate",
    config = function()
        ---- Required bindings ----
        local ensure_installed = {
            "go",
            "gowork",
            "gomod",
            "gosum",
            "gotmpl",
            "templ",

            "lua",
            "rust",
            "zig",
            "sql",

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
            "comment",
            "regex",
        }

        ----- Setup -----
        --- @diagnostic disable:missing-fields
        require("nvim-treesitter.configs").setup {
            highlight = {
                enable = true,
            },
            sync_install = false,
            auto_install = true,
            ensure_installed = ensure_installed,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                        ["ac"] = { query = "@call.outer", desc = "Select outer part of a (function) call" },
                        ["ic"] = { query = "@call.inner", desc = "Select inner part of a (function) call" },

                        ["af"] = {
                            query = "@function.outer",
                            desc = "Select outer part of a function definition",
                        },
                        ["if"] = {
                            query = "@function.inner",
                            desc = "Select inner part of a function definition",
                        },

                        ["as"] = { query = "@class.outer", desc = "Select outer part of a struct (class)" },
                        ["is"] = { query = "@class.inner", desc = "Select inner part of a struct (class)" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- set jumps in jump list
                    goto_next_start = {
                        ["]c"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]s"] = { query = "@class.outer", desc = "Next class start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        ["]a"] = { query = "@argument.inner", desc = "Next inner argument" },
                    },
                    goto_next_end = {
                        ["]C"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]S"] = { query = "@class.outer", desc = "Next class end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                        ["]A"] = { query = "@argument.outer", desc = "Next outer argument" },
                    },
                    goto_previous_start = {
                        ["[c"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
                        ["[s"] = { query = "@class.outer", desc = "Prev class start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                        ["[a"] = { query = "@argument.inner", desc = "Prev inner argument" },
                    },
                    goto_previous_end = {
                        ["[C"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
                        ["[S"] = { query = "@class.outer", desc = "Prev class end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                        ["[A"] = { query = "@argument.inner", desc = "Prev inner argument" },
                    },
                },
                -- allows swapping of parameters in function declarations
                swap = {
                    enable = true,
                    swap_next = {
                        ["<M-l>"] = "@parameter.inner",
                        desc = "Swap with next parameter",
                    },
                    swap_previous = {
                        ["<M-h>"] = "@parameter.inner",
                        desc = "Swap with previous parameter",
                    },
                },
            },
        }

        ---- Extend ts-autotag to handle .templ as .html ----
        require("nvim-ts-autotag").setup {}

        local TagConfigs = require "nvim-ts-autotag.config.init"
        TagConfigs:update(TagConfigs:get("html"):extend("templ", {
            start_tag_pattern = { "element", "tag_start" },
            end_tag_pattern = { "element", "tag_end" },
        }))
    end,
}
