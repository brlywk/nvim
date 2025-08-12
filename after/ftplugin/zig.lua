vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.zig", "*.zon" },
    callback = function(ev)
        vim.lsp.buf.code_action {
            ---@diagnostic disable-next-line
            context = { only = { "source.organizeImports" } },
            apply = true,
        }
    end,
})
