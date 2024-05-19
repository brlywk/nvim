-- keymap for test debugging
vim.keymap.set("n", "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>'", { desc = "Debug test" })
