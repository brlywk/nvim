return {

    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "folke/neoconf.nvim",
    },
    config = function()
        require "custom.config.linting"
    end,
}
