-- really only used for love2d for now

-- should really pack these into global helpers sometime...
local set = vim.keymap.set
local opts = { silent = true, noremap = true }

local cmd = function(cmd_name)
    return ":" .. cmd_name .. "<CR>"
end

-- add which-key category
require("which-key").add { "<leader>l", group = "Language: Lua (Löve2D)" }

opts.desc = "Run: Löve2D"
set("n", "<leader>lr", cmd "LoveRun", opts)

opts.desc = "Stop: Löve2D"
set("n", "<leader>ls", cmd "LoveStop", opts)
