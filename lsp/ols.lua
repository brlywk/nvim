---@type vim.lsp.Config
return {
    cmd = { vim.fn.expand "$HOME/.odin_lsp/ols" },
    filetypes = { "odin" },
    root_markers = { "ols.json", ".git" },
    init_options = {
        collections = {
            { name = "shared", path = vim.fn.expand "$HOME/.odin" },
        },
        odin_command = vim.fn.expand "$HOME/.odin/odin",
    },
}
