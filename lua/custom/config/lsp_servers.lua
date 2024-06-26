local M = {}

----- server settings -----

-- lspconfig: per server configuration
M.server_settings = {
    astro = {},
    -- not really an lsp, but starts crying if it doesn't get a proper config...
    biome = {
        root_dir = function(dir_name)
            local util = require "lspconfig.util"
            return util.root_pattern("biome.json", "biome.jsonc")(dir_name)
                or util.find_package_json_ancestor(dir_name)
                or util.find_node_modules_ancestor(dir_name)
                or util.find_git_ancestor(dir_name)
        end,
    },
    cssls = {
        settings = {
            css = {
                validate = true,
                lint = {
                    -- to not show @tailwind rules as warnings
                    unknownAtRules = "ignore",
                },
            },
        },
    },
    emmet_ls = {},
    gopls = {},
    html = {},
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
    lua_ls = {},
    rust_analyzer = {},
    tailwindcss = {},
    taplo = {},
    templ = {},
    tsserver = {
        init_options = {
            preferences = {
                disableSuggestions = true,
            },
        },
    },
    volar = {
        filetypes = { "vue" },
        init_options = {
            vue = {
                hybridMode = false,
            },
            typescript = {
                -- volar seems to have issue finding typescript
                tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
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

-- generate list of servers mason should install
M.ensure_installed = vim.tbl_keys(M.server_settings)

-- attach function for lsp servers
M.on_attach = function(client, bufnr)
    local set = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- set omnifunction
    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- The Most Important Keymap Ever
    set("i", "<C-s>", vim.lsp.buf.signature_help, opts)

    -- global keymaps
    opts.desc = "Go to definition"
    set("n", "gd", vim.lsp.buf.definition, opts)
    opts.desc = "Show declarations"
    set("n", "gD", vim.lsp.buf.declaration, opts)
    opts.desc = "Show references"
    set("n", "gr", vim.lsp.buf.references, opts)
    opts.desc = "Go to type definition"
    set("n", "gt", vim.lsp.buf.type_definition, opts)

    -- lsp capabilities
    opts.desc = "Code Actions"
    set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- set("n", "<leader>ci", "<cmd>OrganizeImports<CR>", { desc = "Organize imports" })
    opts.desc = "Format with server"
    set("n", "<leader>cF", vim.lsp.buf.format, opts)
    opts.desc = "Restart server"
    set("n", "<leader>cR", "<cmd>LspRestart<CR>", opts)
    opts.desc = "Rename symbol"
    set("n", "<leader>cr", vim.lsp.buf.rename, opts)

    -- setup navic if available
    local navic_installed, navic = pcall(require, "nvim-navic")

    if navic_installed then
        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end
    end
end

return M
