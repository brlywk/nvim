-- extra keys for Go.nvim
local set = vim.keymap.set
local opts = { silent = true, noremap = true }

local cmd = function(cmd_name)
    return ":" .. cmd_name .. "<CR>"
end

-- add which-key category
require("which-key").add { "<leader>lg", group = "Go" }

opts.desc = "Implement interface"
set("n", "<leader>lgi", cmd "GoImpl", opts)
opts.desc = "Struct: implemented interfaces"
set("n", "<leader>lgI", cmd "GoImplements", opts)

opts.desc = "Add comment"
set("n", "<leader>lgc", cmd "GoCmt", opts)

opts.desc = "Add struct tags"
set("n", "<leader>lgt", cmd "GoAddTag", opts)
opts.desc = "Remove struct tags"
set("n", "<leader>lgT", cmd "GoRmTag", opts)

opts.desc = "Fill struct fields"
set("n", "<leader>lgs", cmd "GoFillStruct", opts)
opts.desc = "Fill switch statement"
set("n", "<leader>lgS", cmd "GoFillSwitch", opts)

opts.desc = "Add 'if err'"
set("n", "<leader>lge", cmd "GoIfErr")
