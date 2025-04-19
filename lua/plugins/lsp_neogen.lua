return {
    "danymat/neogen",
    enabled = true,
    version = "*", -- only stable versions
    config = function()
        local neogen = require "neogen"
        neogen.setup { snippet_engine = "luasnip" }

        local opts = { noremap = true, silent = true, desc = "Generate comment" }
        vim.keymap.set("n", "<leader>cc", function()
            neogen.generate()
        end, opts)
    end,
}
