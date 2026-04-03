--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local border_style = require("plugins.theme").border_style

require("blink.cmp").setup {
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "select_and_accept" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-k>"] = { "snippet_forward", "fallback" },
        ["<C-j>"] = { "snippet_backward", "fallback" },
    },

    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = border_style,
            },
        },
        menu = {
            border = border_style,
            draw = {
                gap = 4,
                columns = {
                    { "kind_icon", "label", "label_description", gap = 1 },
                    { "kind" },
                },
            },
        },
    },

    signature = {
        enabled = true,
        window = {
            border = border_style,
        },
    },

    cmdline = {
        completion = { menu = { auto_show = true } },
        keymap = {
            preset = "inherit",
        },
    },

    snippets = { preset = "luasnip" },

    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
}

