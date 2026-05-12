--------------------------------------------------------------------------------
-- Helper
--------------------------------------------------------------------------------
local ft = require "config.lsp_filetypes"

local web_formatter = { "oxfmt", "prettier", lsp_format = "fallback", stop_after_first = true }

--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local conform = require "conform"

local on_save_settings = {
    timeout_ms = 1000,
    lsp_format = "fallback",
    quiet = true,
    async = true,
}

conform.setup {
    notify_on_error = false,

    -- overwrite settings for some formatters
    formatters = {
        odinfmt = {
            command = vim.fn.expand "$HOME/.odin_lsp/odinfmt",
            args = { "-stdin" },
            stdin = true,
        },

        oxfmt = {
            require_cwd = true,
            cwd = require("conform.util").root_file(ft.config_files.oxfmt),
        },

        prettier = {
            require_cwd = true,
            cwd = require("conform.util").root_file(ft.config_files.prettier),
        },

        ["sql-formatter"] = {
            command = "sql-formatter",
            args = {
                "--config",
                vim.json.encode {
                    language = "sql",
                    tabWidth = 4,
                },
            },
        },
    },

    -- which settings to use for autoformatting
    formatters_by_ft = {
        lua = { "stylua" },

        go = { "gofmt" },
        odin = { "odinfmt", lsp_format = "fallback" },
        rust = { "rustfmt" },

        html = web_formatter,
        css = web_formatter,
        scss = web_formatter,

        javascript = web_formatter,
        typescript = web_formatter,
        javascriptreact = web_formatter,
        typescriptreact = web_formatter,

        svelte = web_formatter,
        vue = { lsp_format = "prefer", stop_after_first = true }, -- vue and prettier don't like each other

        json = web_formatter,
        jsonc = web_formatter,
        markdown = web_formatter,

        yaml = { "yamlfix" },
        toml = { "taplo" },
        sql = { "sql-formatter" },

        kt = { "ktfmt", lsp_format = "fallback" },

        python = {
            -- To fix auto-fixable lint errors.
            "ruff_fix",
            -- To run the Ruff formatter.
            "ruff_format",
            -- To organize the imports.
            "ruff_organize_imports",
        },
    },

    -- autoformat on save settings
    format_after_save = on_save_settings,
}

--------------------------------------------------------------------------------
-- Keymap
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>cf", function()
    conform.format(on_save_settings)
end, { desc = "Format code" })
