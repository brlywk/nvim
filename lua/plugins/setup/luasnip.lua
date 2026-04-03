--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local luasnip = require "luasnip"

luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
}

-- load snippets from /snippets directory
local snippet_dir = vim.fs.joinpath(vim.fn.stdpath "config", "snippets")
require("luasnip.loaders.from_lua").load { paths = snippet_dir }

-- some snippets can be reused in other filetypes (e.g. JS and TS)
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascriptreact" })
