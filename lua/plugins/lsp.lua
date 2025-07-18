return {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
        -- Mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- Schemas
        "b0o/SchemaStore.nvim",
        -- Fancy loading UI
        "j-hui/fidget.nvim",
    },
    config = function()
        local border_type = require("config.plugins").border_style

        ---- LSP server settings ----
        local servers = {
            astro = {},

            emmet_ls = {},

            html = {},

            gopls = {},

            jsonls = {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            },

            lua_ls = {},

            ols = {
                cmd = { vim.fn.expand "$HOME/.odin_lsp/ols" },
                init_options = {
                    checker_args = "-vet -vet-cast -strict-style",
                    collections = {
                        { name = "shared", path = vim.fn.expand "$HOME/.odin" },
                    },
                    odin_command = vim.fn.expand "$HOME/.odin/odin",
                },
            },

            rust_analyzer = {},

            svelte = {},

            tailwindcss = {},

            taplo = {},

            templ = {},

            ts_ls = {
                root_dir = require("lspconfig").util.root_pattern "package.json",
                single_file = false,
                init_options = {
                    preferences = {
                        disableSuggestions = true,
                    },
                },
            },

            yamlls = {
                settings = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        }

        ---- Fidget ----
        require("fidget").setup {
            notification = {
                window = { winblend = 0 },
            },
        }

        ---- Completion ----
        local capabilities = nil
        if pcall(require, "cmp_nvim_lsp") then
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

        ---- Mason config ----
        require("mason").setup { ui = { border = border_type } }
        require("mason-tool-installer").setup { ensure_installed = vim.tbl_keys(servers) }

        ---- LSP config ----
        local lspconfig = require "lspconfig"

        -- set up LSP servers
        for server_name, server_opts in pairs(servers) do
            local server_config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, server_opts or {})

            lspconfig[server_name].setup(server_config)
        end

        ---- LSP customization ----

        -- override all floating style windows to use the same border (includes
        -- LSP "hover")
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

        ---@diagnostic disable-next-line: duplicate-set-field
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = border_type
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have client id")

                -- get server specific settings
                local settings = servers[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end

                -- adjust diagnostic infos...
                vim.diagnostic.config {
                    virtual_text = true,
                    signs = {
                        priority = 20,
                        text = {
                            [vim.diagnostic.severity.ERROR] = "",
                            [vim.diagnostic.severity.WARN] = "",
                            [vim.diagnostic.severity.INFO] = "",
                            [vim.diagnostic.severity.HINT] = "",
                        },
                    },
                    severity_sort = true,
                }

                -- helper
                local set = vim.keymap.set
                local opts = { noremap = true, silent = true, buffer = bufnr }

                -- set omnifunction
                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

                -- lsp capabilities
                opts.desc = "Code actions"
                set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                opts.desc = "Format with server"
                set("n", "<leader>cF", vim.lsp.buf.format, opts)
                opts.desc = "Restart server"
                set("n", "<leader>cR", "<cmd>LspRestart<CR>", opts)
                opts.desc = "Rename symbol"
                set("n", "<leader>cr", vim.lsp.buf.rename, opts)
                opts.desc = "Virtual line diagnostics"
                set("n", "<leader>cv", function()
                    local vline_visible = vim.diagnostic.config(nil).virtual_lines or false
                    vim.diagnostic.config {
                        virtual_lines = not vline_visible,
                        virtual_text = vline_visible,
                    }
                end, opts)

                -- override server capabilities if specified in settings
                if settings.server_capabilities then
                    for k, v in pairs(settings.server_capabilities) do
                        if v == vim.NIL then
                            v = nil
                        end

                        client.server_capabilities[k] = v
                    end
                end

                -- setup navic if available
                local navic_installed, navic = pcall(require, "nvim-navic")
                if navic_installed then
                    if client.server_capabilities.documentSymbolProvider then
                        navic.attach(client, bufnr)
                    end
                end
            end,
        })

        -- correctly style the lsp ui windows
        require("lspconfig.ui.windows").default_options.border = border_type
    end,
}
