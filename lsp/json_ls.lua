local ok_schemastore, schemastore = pcall(require, "schemastore")
local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = ft.json,
    root_markers = { "package.json", ".git" },
    init_options = {
        provideFormatter = true,
    },
    settings = {
        json = {
            schemas = ok_schemastore and schemastore.json.schemas() or nil,
            validate = { enable = true },
        },
    },
}
