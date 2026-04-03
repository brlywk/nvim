local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "marksman", "server" },
    filetypes = ft.markdown,
    root_markers = { ".marksman.toml", ".git" },
    settings = {},
}
