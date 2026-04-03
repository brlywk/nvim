-- mason customization
require("mason").setup {
    ui = {
        border = require("plugins.theme").border_style,
    },
}
-- auto install some servers
require("mason-tool-installer").setup {
    ensure_installed = require("config.lsp_servers").ensure_installed,
    auto_update = false,
}
