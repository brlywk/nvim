return {
    "brlywk/section.nvim",
    event = { "VeryLazy" },
    config = function()
        vim.keymap.set(
            "n",
            "<leader>cc",
            require("section").create_comment,
            { noremap = true, silent = true, desc = "Create section comment" }
        )
    end,
}
