--------------------------------------------------------------------------------
-- Helper
--------------------------------------------------------------------------------
local helper = require "config.helper"

-- use biome or prettier, depending on which is configured
local function biome_or_prettier()
    if helper.is_biome_project() then
        return { lsp_format = "prefer", stop_after_first = true }
    elseif helper.is_prettier_project() then
        return { "prettier", lsp_format = "fallback", stop_after_first = true }
    else
        return { lsp_format = "prefer" }
    end
end

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
            cwd = require("conform.util").root_file(helper.prettier_config_files),
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

        html = biome_or_prettier,
        css = biome_or_prettier,
        scss = biome_or_prettier,

        javascript = biome_or_prettier,
        typescript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescriptreact = biome_or_prettier,

        svelte = biome_or_prettier,
        vue = { lsp_format = "prefer", stop_after_first = true }, -- vue and prettier don't like each other

        json = biome_or_prettier,
        jsonc = biome_or_prettier,
        markdown = biome_or_prettier,

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
