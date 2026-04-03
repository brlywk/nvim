--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
local set = vim.keymap.set
local opts = { buffer = true, silent = true, noremap = true }
local cmd = require("config.helper").cmd

-- add which-key category
require("which-key").add { "<leader>l", group = "Language: Go" }

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
opts.desc = "Implement interface"
set("n", "<leader>li", cmd "GoImpl", opts)
opts.desc = "Struct: implemented interfaces"
set("n", "<leader>lI", cmd "GoImplements", opts)
opts.desc = "Add struct tags"
set("n", "<leader>lt", cmd "GoAddTag", opts)
opts.desc = "Remove struct tags"
set("n", "<leader>lT", cmd "GoRmTag", opts)
opts.desc = "Fill struct fields"
set("n", "<leader>ls", cmd "GoFillStruct", opts)
opts.desc = "Fill switch statement"
set("n", "<leader>lS", cmd "GoFillSwitch", opts)
opts.desc = "Add 'if err'"
set("n", "<leader>le", cmd "GoIfErr", opts)
