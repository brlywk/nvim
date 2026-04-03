---@type vim.lsp.Config
return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                -- let ruff handle diagnostics/linting
                ignore = { "*" },
            },
        },
        pyright = {
            -- let ruff handle imports
            disableOrganizeImports = true,
        },
    },
}
