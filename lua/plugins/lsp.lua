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
        local config_lsp = require "plugins.lsp.servers"
        local servers = config_lsp.servers
        local border_type = require("config.plugins").border_style

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
        require("mason-tool-installer").setup { ensure_installed = config_lsp:ensure_installed() }

        -- set up LSP servers
        for server_name, server_opts in pairs(servers) do
            local server_config = vim.tbl_deep_extend(
                "force",
                {},
                { capabilities = capabilities },
                server_opts.config or {}
            )

            vim.lsp.enable(server_name)
            vim.lsp.config[server_name] = server_config
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
                local settings = servers[client.name].config
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
                        ---@diagnostic disable-next-line
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
