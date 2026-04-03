local neogen = require "neogen"
neogen.setup { snippet_engine = "luasnip" }

vim.keymap.set("n", "<leader>cc", function()
    neogen.generate()
end, { desc = "Generate comment" })
