--- @diagnostic disable: missing-fields, param-type-mismatch
----- setup -----

vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

-- get the nice pictograms
local lspkind = require "lspkind"
lspkind.init {}

-- setup nvim-cmp
local cmp = require "cmp"
local luasnip = require "luasnip"
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
    -- completion sources
    sources = {
        -- "default" sources
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },

        -- signature help
        { name = "nvim_lsp_signature_help" },

        -- -- luasnip
        { name = "luasnip", keyword_length = 2 },
    },

    -- keymaps
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm { select = true },
    },

    -- make lsp snippets available
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- add lspkind icons to completion menu
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50 }(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "  (" .. (strings[2] or "") .. ")"

            return kind
        end,
    },
}

-- command line
-- cmp.setup.cmdline("/", {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = "nvim_lsp_document_symbol" },
--         { name = "buffer" },
--     },
-- })
--
-- cmp.setup.cmdline(":", {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = "path" },
--     }, {
--         {
--             name = "cmdline",
--             option = {
--                 ignore_cmds = { "Man", "!" },
--             },
--         },
--     }),
-- })

-- additional completion settings for specific file types
cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})

----- luasnip setup -----

luasnip.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
}

-- load snippets from snippet directory
local config_dir = vim.fn.stdpath "config"
--- @diagnostic disable: param-type-mismatch
local snippet_dir = vim.fs.joinpath(config_dir, "lua/custom/snippets")
-- load snippets from snippet directory
require("luasnip.loaders.from_lua").load { paths = snippet_dir }

-- some snippets can be reused in other filetypes (e.g. JS and TS)
luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("javascriptreact", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascriptreact" })

-- finally, some keymaps
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })
