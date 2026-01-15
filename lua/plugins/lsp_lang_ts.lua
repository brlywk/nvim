return {
    "marilari88/twoslash-queries.nvim",
    ft = { "typescript", "typescriptreact" },
    opts = {
        -- default options:
        multi_line = true, -- to print types in multi line mode
        is_enabled = true, -- to keep disabled at startup and enable it on request with the TwoslashQueriesEnable
        highlight = "Type", -- to set up a highlight group for the virtual text
    },
}
