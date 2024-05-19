----- setup -----
require("neogen").setup {
    snippet_engine = "luasnip",
}

----- keymap -----
vim.keymap.set(
    "n",
    "<leader>cd",
    "<cmd>lua require('neogen').generate()<CR>",
    { noremap = true, silent = true, desc = "Create doc comment" }
)
