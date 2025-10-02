return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    config = function()
        ---- Formatter settings ----
        local prettier = { "prettier", lsp_format = "fallback", stop_after_first = true }
        local prettier_cfg = {
            require_cwd = true,
            cwd = require("conform.util").root_file {
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
            },
        }

        ---- Setup autoformatting ----
        local conform = require "conform"
        local on_save_settings = {
            timeout_ms = 1000,
            lsp_fallback = true,
            quiet = true,
            async = false,
        }

        conform.setup {
            notify_on_error = false,

            -- overwrite settings for some formatters
            formatters = {
                clangd_tidy = {
                    command = "clang-tidy",
                    args = {
                        "--fix",
                        "--fix-errors",
                        "--format-style=file",
                        "--header-filter=.*",
                        "$FILENAME",
                    },
                    stdin = false,
                    exit_codes = { 0, 1 },
                    cwd = require("conform.util").root_file {
                        "compile_commands.json",
                        ".clang-tidy",
                        "CMakeLists.txt",
                    },
                },

                odinfmt = {
                    command = vim.fn.expand "$HOME/.odin_lsp/odinfmt",
                    args = { "-stdin" },
                    stdin = true,
                },

                prettier = prettier_cfg,

                -- rustfmt = {
                --     args = { "--edition", "2024" },
                -- },

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

                zigfmt = {
                    command = "zig",
                    args = { "fmt", "--stdin" },
                    stdin = true,
                },
            },

            -- which settings to use for autoformatting
            formatters_by_ft = {
                go = { "gofmt" },
                lua = { "stylua" },
                odin = { "odinfmt", lsp_format = "fallback" },
                rust = { "rustfmt" },
                zig = { lsp_format = "prefer" },

                gdscript = { "gdformat" },

                html = prettier,
                css = prettier,
                scss = prettier,

                javascript = prettier,
                typescript = prettier,
                javascriptreact = prettier,
                typescriptreact = prettier,

                astro = prettier,
                svelte = prettier,
                vue = { lsp_format = "prefer", stop_after_first = true }, -- vue and prettier don't like each other

                json = prettier,
                markdown = prettier,
                yaml = { "yamlfix" },
                toml = { "taplo" },
                sql = { "sql-formatter" },

                -- templ formatting should be handled by lsp as html formatter will otherwise
                -- jump in and reformat everything incorrectly
                templ = { lsp_format = "prefer", stop_after_first = true },

                python = {
                    -- To fix auto-fixable lint errors.
                    "ruff_fix",
                    -- To run the Ruff formatter.
                    "ruff_format",
                    -- To organize the imports.
                    "ruff_organize_imports",
                },

                -- all the C family stuff
                c = { "clang-format" },
                cc = { "clang-format" },
                cpp = { "clang-format" },
                h = { "clang-format" },
                hh = { "clang-format" },
                hpp = { "clang-format" },
            },

            -- autoformat on save settings
            format_on_save = on_save_settings,
        }

        ---- Keymaps ----
        vim.keymap.set("n", "<leader>cf", function()
            conform.format(on_save_settings)
        end, { desc = "Format code" })
    end,
}
