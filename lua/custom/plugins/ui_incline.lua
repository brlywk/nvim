return {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
    },
    config = function()
        require "custom.config.ui_incline"
    end,
}
