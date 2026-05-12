local ft = require "config.lsp_filetypes"
local merge = require("config.helper").merge

---@type vim.lsp.Config
return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = merge(ft.html, ft.css, ft.javascript, ft.typescript, { "svelte", "astro", "mdx" }),
    root_markers = {
        "tailwind.config.js",
        "tailwind.config.ts",
        "tailwind.config.cjs",
        "postcss.config.js",
        "postcss.config.ts",
        "package.json",
        ".git",
    },
    settings = {},
}
