local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = ft.css,
    root_markers = { "package.json", ".git" },
    settings = {
        css = { validate = true },
        scss = { validate = true },
    },
}
