return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = true,
    config = function()
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

        ----- Keymaps -----
        vim.keymap.set("n", "<leader>fe", ":Oil<CR>", { noremap = true, silent = true, desc = "Oil" })

        ---- Integrations ----
        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost",
            callback = function(event)
                if event.data.actions.type == "move" then
                    Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
                end
            end,
        })
    end,
}
