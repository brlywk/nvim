local M = {}

-- names of servers to enable the language server for (must match filename in
-- `lsp` folder)
M.enable_servers = {
    "lua_ls",

    "gopls",
    "ols",
    "rust_analyzer",
    "kotlin_ls",

    -- web stuff
    "ts_ls",
    "biome",
    "emmet_ls",
    "html",
    "css_ls",
    "json_ls",

    -- frameworks
    "svelte",
    "tailwindcss",

    -- python
    "python_pyright",
    "python_ruff",

    -- misc
    "marksman",
    "taplo",
    "yaml_ls",
}

-- automatically install these servers; needed as some servers are named
-- differently here than in Mason
M.ensure_installed = {
    "lua-language-server",
    "stylua",

    "gopls",
    "rust-analyzer",

    "typescript-language-server",
    "html-lsp",
    "css-lsp",
    "tailwindcss-language-server",

    "svelte-language-server",

    "json-lsp",
    "marksman",
    "taplo",
    "yaml-language-server",
}

return M
