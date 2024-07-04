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

-- config lsp servers
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- add a border to these lsp elements that don't have one by default
local lsp_add_borders = {
	hover = "hover",
	signatureHelp = "signature_help",
}

mason_lspconfig.setup_handlers({
	function(server_name)
		local server_config = vim.tbl_deep_extend(
			"force",
			{},
			{ capabilities = capabilities, on_attach = lsp_settings.on_attach },
			lsp_settings.server_settings[server_name] or {}
		)

		lspconfig[server_name].setup(server_config)

		-- must be done after lsp is initialized
		for name, funcName in pairs(lsp_add_borders) do
			vim.lsp.handlers["textDocument/" .. name] = vim.lsp.with(vim.lsp.handlers[funcName], {
				border = "single",
			})
		end
	end,
})
