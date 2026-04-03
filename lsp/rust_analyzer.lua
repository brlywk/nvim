---@type vim.lsp.Config
return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "Cargo.lock", ".git" },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                extraArgs = { "--", "-W", "clippy::pedantic" },
            },
            inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = false },
                closingBraceHints = { enable = false },
                closureReturnTypeHints = { enable = false },
                discriminantHints = { enable = false },
                expressionAdjustmentHints = { enable = false },
                implicitDrops = { enable = false },
                lifetimeElisionHints = { enable = false },
                parameterHints = { enable = false },
                reborrowHints = { enable = false },
                renderColons = false,
                typeHints = { enable = false },
            },
        },
    },
}
