----- setup -----
require("tailwind-sorter").setup {
    on_save_enabled = true,
    on_save_pattern = {
        "*.astro",
        "*.html",
        "*.js",
        "*.jsx",
        "*.svelte",
        "*.tsx",
        "*.ts",
    },
    node_path = "node",
}
