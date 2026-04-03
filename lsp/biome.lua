local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "biome", "lsp-proxy" },
    filetypes = ft.merge(ft.javascript, ft.typescript, ft.json, ft.css),
    root_markers = { "biome.json", "biome.jsonc", "package.json", ".git" },
    settings = {},
}
