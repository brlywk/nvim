----- setup -----
require("oil").setup {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,

    columns = { "icon" },

    lsp_file_methods = {
        -- automatically save files if they happen to have been modified by LSP
        -- actions like renaming
        autosave_changes = true,
    },

    keymaps = {
        ["q"] = "actions.close",
    },

    view_options = {
        show_hidden = false,

        -- set some folders to be hidden by default
        is_hidden_file = function(name, _)
            local startsWithDot = vim.startswith(name, ".")
            local nodeModules = vim.startswith(name, "node_modules")
            local rustBuilds = vim.startswith(name, "target")

            return startsWithDot or nodeModules or rustBuilds
        end,
    },
}

----- keymaps -----

vim.keymap.set("n", "<leader>fe", ":Oil<CR>", { noremap = true, silent = true, desc = "Oil" })
