-- https://github.com/b0o/SchemaStore.nvim
return {
	"b0o/schemastore.nvim",
	event = "VeryLazy",
	config = function()
		-- set up lspconfig for servers that can use schemas
		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					schemaStore = {
						-- You must disable built-in schemaStore support if you want to use
						-- this plugin and its advanced options like `ignore`.
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
	end,
}