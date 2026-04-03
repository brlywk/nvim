local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = ft.merge(ft.html, ft.css, ft.javascript, ft.typescript),
    root_markers = { ".git" },
    settings = {},
}
