----- setup -----

local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        mappings = {
            -- enable some mappings in insert mode
            ["i"] = {
                -- default actions
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,

                -- hop actions
                ["<C-space>"] = function(prompt_bufnr)
                    telescope.extensions.hop.hop(prompt_bufnr)
                end,
            },
        },

        file_ignore_patterns = {
            "node_modules",
            "target", -- rust build output
        },
    },

    extensions = {
        fzf = {},
        hop = {
            trace_entry = true,
        },
        wrap_results = true,

        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
    },
}

-- load extensions
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "hop")
pcall(telescope.load_extension, "ui-select")

----- keymaps -----
local set = vim.keymap.set
local builtin = require "telescope.builtin"

-- buffer specific keymaps
set("n", "<leader>bb", builtin.buffers, { desc = "Find open buffers" })

-- search keymaps
set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
set("n", "<leader>fg", builtin.live_grep, { desc = "Grep files" })
set("n", "<leader>fG", builtin.git_files, { desc = "Find in git" })
set("n", "<leader>fh", builtin.help_tags, { desc = "Find in neovim help" })
set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent" })
set("n", "<leader>fw", builtin.grep_string, { desc = "Find current word" })

-- lsp specific keymaps
set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Show definitions" })
set("n", "<leader>li", builtin.lsp_implementations, { desc = "Show implementations" })
set("n", "<leader>lr", builtin.lsp_references, { desc = "Show references" })
set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Show document symbols" })
set("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "Show type definitions" })
set("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, { desc = "Show workspace symbols" })
