----- setup -----

-- define some sublists
local prettier = { "prettierd", "prettier" }
local gofmt = { "gofmt", "gofumpt" }

local conform = require "conform"

conform.setup {
    formatters_by_ft = {
        lua = { "stylua" },
        go = { gofmt },
        rust = { "rustfmt" },

        html = { prettier },
        css = { prettier },
        scss = { prettier },

        javascript = { prettier },
        typescript = { prettier },
        javascriptreact = { prettier },
        typescriptreact = { prettier },

        astro = { prettier },
        svelte = { prettier },

        json = { prettier },
        markdown = { prettier },
        yaml = { "yamlfix" },
        toml = { "taplo" },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
        quiet = true,
    },
}

----- keymaps -----

vim.keymap.set("n", "<leader>cf", function()
    conform.format {
        timeout_ms = 500,
        lsp_fallback = true,
        quiet = true,
        async = false,
    }
end, { desc = "Format code" })
