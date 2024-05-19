----- setup -----
local trouble = require "trouble"
trouble.setup {}

----- keymap -----
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

opts.desc = "Document diagnostics"
set("n", "<leader>xd", function()
    trouble.open "document_diagnostics"
end, opts)

opts.desc = "Next"
set("n", "<leader>xn", function()
    trouble.next()
end, opts)

opts.desc = "Previous"
set("n", "<leader>xp", function()
    trouble.prev()
end, opts)

opts.desc = "Workspace diagnostics"
set("n", "<leader>xw", function()
    trouble.open "workspace_diagnostics"
end, opts)

opts.desc = "Open"
set("n", "<leader>xx", function()
    trouble.open()
end, opts)
