return {
    "hiphish/rainbow-delimiters.nvim",
    enable = true,
    config = function()
        vim.g.rainbow_delimiters = {
            whitelist = { "rust" },
        }
    end,
}
