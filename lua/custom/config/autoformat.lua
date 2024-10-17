----- setup -----

-- define some sublists
local gofmt = { "gofmt", "gofumpt", stop_after_first = true }

local prettier = { "prettierd", "prettier", stop_after_first = true }
local prettier_cfg = {
	require_cwd = true,
	cwd = require("conform.util").root_file({
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
	}),
}

local conform = require("conform")

local web_formatter = function(bufnr)
	if
		conform.get_formatter_info("prettierd", bufnr).available
		or conform.get_formatter_info("prettier", bufnr).available
	then
		return prettier
	elseif conform.get_formatter_info("biome", bufnr).available then
		return { "biome" }
	else
		return {}
	end
end

conform.setup({
	formatters = {
		-- only use prettier if a prettier config is found
		prettier = prettier_cfg,
		prettierd = prettier_cfg,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = { gofmt },
		rust = { "rustfmt" },

		html = web_formatter,
		css = web_formatter,
		scss = web_formatter,

		javascript = web_formatter,
		typescript = web_formatter,
		javascriptreact = web_formatter,
		typescriptreact = web_formatter,

		astro = web_formatter,
		svelte = web_formatter,
		-- vue requires lsp fallback formatting
		vue = {},

		json = web_formatter,
		markdown = web_formatter,
		yaml = { "yamlfix" },
		toml = { "taplo" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })

		-- set vue explicitly
		if ft == "vue" then
			vim.lsp.buf.format()
		else
			require("conform").format({ bufnr = args.buf, quiet = true, timeout_ms = 500, lsp_fallback = true })
		end
	end,
})

----- keymaps -----

vim.keymap.set("n", "<leader>cf", function()
	conform.format({
		timeout_ms = 500,
		lsp_fallback = true,
		quiet = true,
		async = false,
	})
end, { desc = "Format code" })
