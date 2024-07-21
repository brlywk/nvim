----- setup -----

-- fidget
require("fidget").setup({
	notification = {
		window = { winblend = 0 },
	},
})

-- check for cmp and get capabilities
local cmp_found, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = nil

if cmp_found then
	capabilities = cmp_nvim_lsp.default_capabilities()
end

-- load custom server settings
local lsp_settings = require("custom.config.lsp_settings")

-- mason & co
require("mason").setup({
	ui = {
		border = "single",
	},
})
require("mason-tool-installer").setup({ ensure_installed = lsp_settings.ensure_installed })
require("mason-lspconfig").setup({})

-- config lsp servers
local lspconfig = require("lspconfig")

-- add a border to these lsp elements that don't have one by default
local lsp_add_borders = {
	hover = "hover",
	signatureHelp = "signature_help",
}

-- TODO:
-- 1. Replace tsserver with vtsls
-- 2. Adjust lsp config so that every server config is split into "opts" (passed to lspconfig), and "extra" (name wip)
-- that do additional config (e.g. for Vue / Volar that is deactivating tsserver and adding js, jsx, ts, tsx to
-- file types)

-- setup servers
for server_name, server_opts in pairs(lsp_settings.server_settings) do
	local server_config = vim.tbl_deep_extend(
		"force",
		{},
		{ capabilities = capabilities, on_attach = lsp_settings.on_attach },
		server_opts or {}
	)

	lspconfig[server_name].setup(server_config)

	-- must be done after lsp is initialized
	for name, funcName in pairs(lsp_add_borders) do
		vim.lsp.handlers["textDocument/" .. name] = vim.lsp.with(vim.lsp.handlers[funcName], {
			border = "single",
		})
	end
end
