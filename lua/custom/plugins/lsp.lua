return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Neodev and Neoconf
        "folke/neoconf.nvim",

        -- Schemas
        "b0o/SchemaStore.nvim",

        -- Fancy loading UI
        "j-hui/fidget.nvim",
    },
    config = function()
        require "custom.config.lsp"
    end,
}
