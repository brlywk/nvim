local M = {}

local LSP_SERVERS_DIR = "lsp_servers"

-- helper to get path relative to this file --
local function get_file_path(directory, level)
	level = level or 2

	local path = require("plenary.path")
	local source = debug.getinfo(level, "S").source
	local dir = source:sub(1, 1) == "@" and source:sub(2) or source
	dir = vim.fn.fnamemodify(dir, ":p:h")

	return path:new(dir, directory):absolute()
end

-- helper to load server settings from single files in some directory --
local function load_lsp_config(directory)
	local scan = require("plenary.scandir")
	local file_list = scan.scan_dir(directory, { search_pattern = "%.lua$" })
	local server_settings = {}

	for _, file in ipairs(file_list) do
		local server_name = vim.fn.fnamemodify(file, ":t:r")
		local config = dofile(file)

		server_settings[server_name] = config
	end

	return server_settings
end

-- lspconfig: per server configuration
M.server_settings = load_lsp_config(get_file_path(LSP_SERVERS_DIR, 2))

-- generate list of servers mason should install
M.ensure_installed = vim.tbl_keys(M.server_settings)

-- attach function for lsp servers
M.on_attach = function(client, bufnr)
	local set = vim.keymap.set
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set omnifunction
	vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- The Most Important Keymap Ever
	set("i", "<C-s>", vim.lsp.buf.signature_help, opts)

	-- global keymaps
	opts.desc = "Go to definition"
	set("n", "gd", vim.lsp.buf.definition, opts)
	opts.desc = "Show declarations"
	set("n", "gD", vim.lsp.buf.declaration, opts)
	opts.desc = "Show references"
	set("n", "gr", vim.lsp.buf.references, opts)
	opts.desc = "Go to type definition"
	set("n", "gt", vim.lsp.buf.type_definition, opts)

	-- lsp capabilities
	opts.desc = "Code Actions"
	set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	opts.desc = "Format with server"
	set("n", "<leader>cF", vim.lsp.buf.format, opts)
	opts.desc = "Restart server"
	set("n", "<leader>cR", "<cmd>LspRestart<CR>", opts)
	opts.desc = "Rename symbol"
	set("n", "<leader>cr", vim.lsp.buf.rename, opts)

	-- setup navic if available
	local navic_installed, navic = pcall(require, "nvim-navic")

	if navic_installed then
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
	end
end

return M
