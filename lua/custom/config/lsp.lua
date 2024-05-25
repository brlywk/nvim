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
        local disabled_lsp = neoconf.get "lsp.disable" or ""
        if disabled_lsp == server_name then
            return
        end

        local server_config = vim.tbl_deep_extend(
            "force",
            {},
            { capabilities = capabilities, on_attach = lsp_settings.on_attach },
            -- security measure to avoid LSPs that are not in the ensure_installed list but expect
            -- to be set up (looking at you biome...) to not throw a fit when called (with the MOST USELESS error in existence)
            lsp_settings.server_settings[server_name] or {}
        )

        --- @type table
        local ft_takeover = neoconf.get "lsp" or {}

        if #vim.tbl_keys(ft_takeover) > 0 then
            for neoconf_ft, neoconf_server in pairs(ft_takeover) do
                if neoconf_server == server_name then
                    server_config.filetypes = server_config.filetypes or {}
                    vim.list_extend(server_config.filetypes, { neoconf_ft })
                end
            end
        end

        lspconfig[server_name].setup(server_config)
    end,
}
