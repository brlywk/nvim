----- setup -----

-- neodev just needs to be initialized
require("neodev").setup {}

-- neoconf needs to be run before any lsp server config
local neoconf = require "neoconf"
neoconf.setup {}

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
local mason_lspconfig = require "mason-lspconfig"

mason_lspconfig.setup_handlers {
    function(server_name)
        -- skip if server is disabled via neoconf
        if neoconf.get(server_name .. ".disable") then
            return
        end

        local server_config = vim.tbl_deep_extend(
            "force",
            {},
            { capabilities = capabilities, on_attach = lsp_settings.on_attach },
            lsp_settings.server_settings[server_name]
        )

        -- VUE: we also need typescript and javascript to be handled by volar
        if server_name == "volar" then
            server_config.filetypes = { "vue", "typescript", "javascript" }
        end

        lspconfig[server_name].setup(server_config)
    end,
}

-- for name, server_config in pairs(lsp_settings.server_settings) do
--     -- VUE: we need to check if tsserver needs to be disabled (needs to be checked in neoconf)
--     -- local is_enabled = neoconf.get(name .. ".disable") or true
--     -- print("server: " .. name .. " should be enabled? " .. tostring(is_enabled))
--
--     server_config = vim.tbl_deep_extend(
--         "force",
--         {},
--         { capabilities = capabilities, on_attach = lsp_settings.on_attach },
--         server_config
--     )
--
--     -- VUE: we also need typescript and javascript to be handled by volar
--     if name == "volar" then
--         print "volar detected"
--         server_config.filetypes = { "vue", "typescript", "javascript" }
--     end
--
--     -- if is_enabled then
--     lspconfig[name].setup(server_config)
--     -- end
-- end
