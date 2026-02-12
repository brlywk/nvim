---@diagnostic disable:missing-fields,param-type-mismatch,assign-type-mismatch
---@diagnostic disable:undefined-global
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    enabled = not vim.g.vscode,
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
        local border_type = require("config.plugins").border_style

        ---- nvim-wide lsp setup ----
        local completion_opts = { "menuone", "noselect", "noinsert", "preview" }
        vim.opt.completeopt = completion_opts

        ---- load pictograms ----
        local lspkind = require "lspkind"
        lspkind.init {}

        ---- load essentials ----
        local cmp = require "cmp"
        local luasnip = require "luasnip"
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        ---- styling ----
        -- important: assumes that I always use the one and only color theme ;)
        local colors = require("catppuccin.palettes").get_palette "mocha"
        vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = colors.blue, bg = colors.base })
        vim.api.nvim_set_hl(0, "CmpSel", { fg = colors.base, bg = colors.blue })
        vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.blue })

        ---- setup nvim-cmp ----
        cmp.setup {
            -- no preselection
            preselect = cmp.PreselectMode.None,
            -- completion options
            completion = {
                completeopt = vim.fn.join(completion_opts, ","),
            },
            -- sources
            sources = {
                -- default
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "buffer" },
                -- signature help
                { name = "nvim_lsp_signature_help" },
                -- luasnip
                { name = "luasnip", keyword_length = 2 },
            },
            -- keymap
            mapping = {
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm { select = true },
            },
            -- snippets
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- format for completion window
            formatting = {
                fields = { "abbr", "icon", "kind", "menu" },
                format = lspkind.cmp_format {
                    maxwidth = {
                        menu = 10,
                        abbr = 50,
                    },
                    ellipsis_char = "...",
                    show_labelDetails = false,
                },
            },
            -- window styling
            window = {
                completion = {
                    border = border_type,
                    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
                },
                documentation = {
                    border = border_type,
                    winhighlight = "Normal:CmpDoc",
                },
            },
        }

        -- nvim-cmp: command line completion --
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "nvim_lsp_document_symbol" },
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })

        ---- luasnip ----
        luasnip.config.set_config {
            history = false,
            updateevents = "TextChanged,TextChangedI",
        }

        -- load snippets from /snippets directory
        local config_dir = vim.fn.stdpath "config"
        local snippet_dir = vim.fs.joinpath(config_dir, "lua/plugins/snippets")
        require("luasnip.loaders.from_lua").load { paths = snippet_dir }

        -- some snippets can be reused in other filetypes (e.g. JS and TS)
        luasnip.filetype_extend("typescript", { "javascript" })
        luasnip.filetype_extend("javascriptreact", { "javascript" })
        luasnip.filetype_extend("typescriptreact", { "javascriptreact" })

        -- keymaps
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
    end,
}
