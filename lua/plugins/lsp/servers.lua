local M = {}

---- dependencies ----
local ok_schemastore, schemastore = pcall(require, "schemastore")

---@class LspConfig
---@field ensure_installed boolean Whether to use Mason to install and configure the server
---@field config table The actual LSP config for the server

--- List of configured LSP servers
---@type table<string, LspConfig>
M.servers = {
    astro = {
        ensure_installed = true,
        config = {},
    },

    -- C / C++
    clangd = {
        ensure_installed = false,
        config = {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
        },
    },

    emmet_ls = {
        ensure_installed = true,
        config = {},
    },

    html = {
        ensure_installed = true,
        config = {},
    },

    gdscript = {
        ensure_installed = false,
        config = {},
    },

    gopls = {
        ensure_installed = true,
        config = {},
    },

    jsonls = {
        ensure_installed = true,
        config = {
            settings = {
                json = {
                    schemas = ok_schemastore and schemastore.json.schemas(),
                    validate = { enable = true },
                },
            },
        },
    },

    lua_ls = {
        ensure_installed = true,
        config = {},
    },

    -- Markdown
    marksman = {
        ensure_installed = true,
        config = {},
    },

    -- Odin
    ols = {
        ensure_installed = false,
        config = {
            cmd = { vim.fn.expand "$HOME/.odin_lsp/ols" },
            init_options = {
                collections = {
                    { name = "shared", path = vim.fn.expand "$HOME/.odin" },
                },
                odin_command = vim.fn.expand "$HOME/.odin/odin",
            },
        },
    },

    -- Python
    ruff = {
        ensure_installed = false,
        config = {},
    },

    rust_analyzer = {
        ensure_installed = true,
        config = {
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                        extraArgs = { "--", "-W", "clippy::pedantic" },
                    },
                    inlayHints = {
                        bindingModeHints = {
                            enable = false,
                        },
                        chainingHints = {
                            enable = false,
                        },
                        closingBraceHints = {
                            enable = false,
                        },
                        closureReturnTypeHints = {
                            enable = false,
                        },
                        discriminantHints = {
                            enable = false,
                        },
                        expressionAdjustmentHints = {
                            enable = false,
                        },
                        implicitDrops = {
                            enable = false,
                        },
                        lifetimeElisionHints = {
                            enable = false,
                        },
                        parameterHints = {
                            enable = false,
                        },
                        reborrowHints = {
                            enable = false,
                        },
                        renderColons = false,
                        typeHints = {
                            enable = false,
                        },
                    },
                },
            },
        },
    },

    svelte = {
        ensure_installed = true,
        config = {},
    },

    tailwindcss = {
        ensure_installed = true,
        config = {},
    },

    taplo = {
        ensure_installed = true,
        config = {},
    },

    templ = {
        ensure_installed = true,
        config = {},
    },

    ts_ls = {
        ensure_installed = true,
        config = {
            root_dir = function(bufnr, on_dir)
                on_dir(vim.fs.root(bufnr, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }))
            end,
            workspace_required = true,
            init_options = {
                preferences = {
                    -- disable ts_ls's own suggestions when linting via eslint
                    -- is enabled
                    disableSuggestions = true,
                },
            },
        },
    },

    yamlls = {
        ensure_installed = true,
        config = {
            settings = {
                schemaStore = {
                    enable = false,
                    url = "",
                },
                schemas = ok_schemastore and schemastore.yaml.schemas(),
            },
        },
    },
}

--- Returns a list of LSP server names to be installed with Mason
---@return string[]
M.ensure_installed = function(self)
    local ensure_installed = {}

    for server_name, server_config in pairs(self.servers) do
        if server_config.ensure_installed then
            table.insert(ensure_installed, server_name)
        end
    end

    return ensure_installed
end

return M
