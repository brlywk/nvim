local ft = require "config.lsp_filetypes"
local merge = require("config.helper").merge

---@type vim.lsp.Config
return {
    cmd = { "emmet-language-server", "--stdio" },
    filetypes = merge(ft.html, ft.css, ft.javascript, ft.typescript),
    root_markers = { ".git" },
    settings = {},
}
