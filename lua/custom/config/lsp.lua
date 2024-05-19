----- setup -----

-- neodev just needs to be initialized
require("neodev").setup {}

-- neoconf needs to be run before any lsp server config
require("neoconf").setup {}

-- same for fidget
require("fidget").setup {
    notification = {
        window = { winblend = 0 },
    },
}

-- check for cmp and get capabilities
local cmp_found, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = nil

if cmp_found then
    capabilities = cmp_nvim_lsp.default_capabilities()
end

-- load custom server settings
local lsp_settings = require "custom.config.lsp_servers"

-- mason really has nothing to do here...
require("mason").setup()

-- ... but the "automatic mason install-some-stuff-a-majig" has
require("mason-tool-installer").setup { ensure_installed = lsp_settings.ensure_installed }

-- config lsp servers
local lspconfig = require "lspconfig"

for name, server_config in pairs(lsp_settings.server_settings) do
    server_config = vim.tbl_deep_extend(
        "force",
        {},
        { capabilities = capabilities, on_attach = lsp_settings.on_attach },
        server_config
    )
    lspconfig[name].setup(server_config)
end
