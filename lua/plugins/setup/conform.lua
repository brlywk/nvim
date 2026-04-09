--------------------------------------------------------------------------------
-- Helper
--------------------------------------------------------------------------------
local helper = require "config.helper"

local prettier_config_files = {
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
}

-- NOTE: Biome is only so-so, so hardcode prettier for now but check out oxfmt /
-- oxlint (oxc.rs) and adjust config to use oxfmt first and prettier afterwards
-- or sth...
local prettier_config = { "prettier", lsp_format = "fallback", stop_after_first = true }

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

        prettier = {
            require_cwd = true,
            cwd = require("conform.util").root_file(prettier_config_files),
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

        html = prettier_config,
        css = prettier_config,
        scss = prettier_config,

        javascript = prettier_config,
        typescript = prettier_config,
        javascriptreact = prettier_config,
        typescriptreact = prettier_config,

        svelte = prettier_config,
        vue = { lsp_format = "prefer", stop_after_first = true }, -- vue and prettier don't like each other

        json = prettier_config,
        jsonc = prettier_config,
        markdown = prettier_config,

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
