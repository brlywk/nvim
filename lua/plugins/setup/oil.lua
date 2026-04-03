local border_style = require("plugins.theme").border_style

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
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
            local starts_with_dot = vim.startswith(name, ".")
            local node_modules = vim.startswith(name, "node_modules")
            local rust_builds = name == "target"
            local godot_id_file = vim.endswith(name, ".gd.uid")
            local css_module_type_def = vim.endswith(name, ".module.css.d.ts")

            return starts_with_dot or node_modules or rust_builds or godot_id_file or css_module_type_def
        end,
    },

    float = {
        border = border_style,
    },
    confirmation = {
        border = border_style,
    },
}

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>fe", ":Oil<CR>", { noremap = true, silent = true, desc = "Oil" })

--------------------------------------------------------------------------------
-- Integration
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("User", {
    pattern = "OilActionsPost",
    callback = function(event)
        if event.data.actions.type == "move" then
            ---@diagnostic disable-next-line: undefined-global
            Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
    end,
})
