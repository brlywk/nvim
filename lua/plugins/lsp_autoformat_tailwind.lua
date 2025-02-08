return {
    "laytan/tailwind-sorter.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
    },
    build = "cd formatter && npm ci && npm run build",
    config = function()
        require("tailwind-sorter").setup {
            on_save_enabled = true,
            on_save_pattern = {
                "*.astro",
                "*.html",
                "*.js",
                "*.jsx",
                "*.svelte",
                "*.templ",
                "*.ts",
                "*.tsx",
                "*.vue",
            },
            node_path = "node",
        }
    end,
}
