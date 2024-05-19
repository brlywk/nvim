return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- adapters
        "leoluz/nvim-dap-go",
    },
    config = function()
        require "custom.config.debug"
    end,
}
