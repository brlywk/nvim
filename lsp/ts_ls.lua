local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = ft.merge(ft.javascript, ft.typescript),
    root_markers = {
        "tsconfig.json",
        "tsconfig.base.json",
        "tsconfig.node.json",
        "tsconfig.app.json",
        "jsconfig.json",
        "package.json",
        ".git",
    },
    workspace_required = true,
    init_options = {
        preferences = {
            -- disable ts_ls suggestions when eslint/biome handles linting
            disableSuggestions = true,
        },
    },
}
