return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- pictograms
		"onsails/lspkind.nvim",

		-- sources
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		-- show function signature
		"hrsh7th/cmp-nvim-lsp-signature-help",

		-- snippets
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		require("custom.config.completion")
	end,
	enabled = true,
}
