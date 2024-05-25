return {
    "stevearc/conform.nvim",
    dependencies = {
        "folke/neoconf.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require "custom.config.autoformat"
    end,
}
