local ft = require "config.lsp_filetypes"

---@type vim.lsp.Config
return {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = ft.html,
    root_markers = { "package.json", ".git" },
    init_options = {
        provideFormatter = true,
    },
    settings = {},
}
