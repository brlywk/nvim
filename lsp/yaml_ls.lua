local ok_schemastore, schemastore = pcall(require, "schemastore")
local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = ft.yaml,
    root_markers = { ".git" },
    settings = {
        yaml = {
            -- disable built-in schema store in favor of SchemaStore.nvim
            schemaStore = { enable = false, url = "" },
            schemas = ok_schemastore and schemastore.yaml.schemas() or nil,
        },
    },
}
